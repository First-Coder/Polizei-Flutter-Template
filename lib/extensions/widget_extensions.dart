import 'package:police_flutter_template/extensions/widgets/hover_effect.dart';
import 'package:police_flutter_template/extensions/widgets/pulse_animation_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// General-purpose widget extensions to enhance UI affordances.
///
/// These helpers are designed to be:
/// - easy to chain (`someWidget.animatePulse().withHoverEffect(...)`)
/// - safe to disable (`enabled: false` returns the original widget)
///
/// Included effects:
/// - [liIcon]: list-item affordance (icon + spacing + content), supports Columns
/// - [animatePulse]: opacity pulsing via [PulseAnimationWrapper]
/// - [withHoverEffect]: hover/tap affordance via [HoverEffect] (desktop/web focused)
extension WidgetExtensions on Widget {
  /// Prepends an icon to this widget to render it like a bullet/list item.
  ///
  /// Behavior:
  /// - **Default:** wraps the current widget in a `Row`:
  ///   `Icon` + spacing + `Expanded(child: this)`.
  /// - **Special case – Column:** if this modifier is applied to a [Column], it will
  ///   wrap **each direct child** of that Column as an individual list item (icon per child),
  ///   while preserving the Column's layout properties (alignment, direction, etc.).
  ///
  /// Nesting / indentation:
  /// - Uses [Data.inherit] with [UnorderedListData] to increment a logical list depth.
  ///   (This allows nested list-like structures to be styled/handled consistently.)
  ///
  /// Parameters:
  /// - [icon]: the icon placed before the item (defaults to `LucideIcons.check`).
  /// - [color]: optional icon color.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   crossAxisAlignment: CrossAxisAlignment.start,
  ///   children: const [
  ///     Text('Online-Anzeige erstatten'),
  ///     Text('Fundstelle melden'),
  ///   ],
  /// ).liIcon(color: Colors.green);
  /// ```
  ///
  /// Tip:
  /// - When calling `.liIcon()` on a Column, you typically **should not** also call
  ///   `.liIcon()` on the individual children, otherwise you will see duplicate icons.
  TextModifier liIcon({IconData icon = LucideIcons.check, Color? color}) =>
      WrappedText(
        wrapper: (context, child) {
          UnorderedListData? data = Data.maybeOf(context);
          int depth = data?.depth ?? 0;
          TextStyle style = DefaultTextStyle.of(context).style;
          double size = (style.fontSize ?? 12) / 6 * 6;

          Widget wrapSingle(Widget item) {
            return IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:
                        ((style.fontSize ?? 12) * (style.height ?? 1)) * 1.2,
                    child: Icon(icon, size: size, color: color),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Data.inherit(
                      data: UnorderedListData(depth: depth + 1),
                      child: item,
                    ),
                  ),
                ],
              ),
            );
          }

          if (child is Column) {
            final Column col = child;
            return Column(
              key: col.key,
              mainAxisAlignment: col.mainAxisAlignment,
              mainAxisSize: col.mainAxisSize,
              crossAxisAlignment: col.crossAxisAlignment,
              textDirection: col.textDirection,
              verticalDirection: col.verticalDirection,
              textBaseline: col.textBaseline,
              children: [for (final w in col.children) wrapSingle(w)],
            );
          }

          return wrapSingle(child);
        },
        child: this,
      );

  /// Applies a pulsing opacity animation to this widget.
  ///
  /// This is useful for subtle attention cues (e.g. status indicators).
  /// If [enabled] is `false`, the widget is returned unchanged.
  ///
  /// See also:
  /// - [PulseAnimationWrapper] for implementation details.
  Widget animatePulse({
    bool enabled = true,
    Duration duration = const Duration(seconds: 2),
    double lowerBound = 0.5,
    double upperBound = 1.0,
    Curve curve = Curves.easeInOut,
  }) {
    if (!enabled) {
      return this;
    }
    return PulseAnimationWrapper(
      duration: duration,
      lowerBound: lowerBound,
      upperBound: upperBound,
      curve: curve,
      child: this,
    );
  }

  /// Wraps this widget with a lightweight hover / press affordance for
  /// **web and desktop** platforms.
  ///
  /// The effect is implemented using:
  /// - [MouseRegion] to detect pointer enter/exit (hover)
  /// - [AnimatedScale] for a subtle "lift" animation
  /// - [AnimatedContainer] for background, shadow and border transitions
  ///
  /// Notes:
  /// - On mobile platforms there is no hover; the widget will be built without
  ///   hover listeners (but it can still be tappable via [onTap]).
  /// - If you provide [onTap], the cursor becomes a click cursor on hover.
  ///
  /// Common usage (cards/tiles):
  /// ```dart
  /// Card(child: ...)
  ///   .withHoverEffect(
  ///     hoverScale: 1.02,
  ///     borderColor: Colors.gray[200],
  ///     hoverBorderColor: Colors.blue[400],
  ///   );
  /// ```
  ///
  /// See also:
  /// - [HoverEffect] for the platform gating and rendering details.
  Widget withHoverEffect({
    /// The scale applied while hovered.
    ///
    /// Keep this subtle (e.g. 1.01–1.03) to avoid layout jitter.
    double hoverScale = 1.00,

    /// Animation duration used by both scale and decoration transitions.
    Duration duration = const Duration(milliseconds: 140),

    /// Animation curve used by both scale and decoration transitions.
    Curve curve = Curves.easeOut,

    /// Shadow when not hovered.
    List<BoxShadow>? normalShadow,

    /// Shadow while hovered (often a bit stronger / more blurred).
    List<BoxShadow>? hoverShadow,

    /// Background color when not hovered.
    Color? normalBackground,

    /// Background color while hovered.
    Color? hoverBackground,

    /// Border color when not hovered.
    ///
    /// If null, no border is drawn in the normal state.
    Color? borderColor,

    /// Border color while hovered.
    ///
    /// If null, falls back to [borderColor].
    Color? hoverBorderColor,

    /// Border width for both normal and hover states.
    double borderWidth = 1,

    /// Border radius applied to the container and the clipping.
    BorderRadius? borderRadius,

    /// Optional padding applied inside the decorated container.
    EdgeInsetsGeometry? padding,

    /// Optional tap handler. If provided, the widget becomes tappable.
    VoidCallback? onTap,

    /// Enables/disables the behavior. If false, returns a non-hovering wrapper.
    bool enabled = true,
  }) {
    return HoverEffect(
      enabled: enabled,
      hoverScale: hoverScale,
      duration: duration,
      curve: curve,
      normalShadow: normalShadow,
      hoverShadow: hoverShadow,
      normalBackground: normalBackground,
      hoverBackground: hoverBackground,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      padding: padding,
      onTap: onTap,
      child: this,
    );
  }
}
