import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

/// Builds a "lightweight" button style used across the app for subtle actions.
///
/// This helper centralizes style decisions:
/// - Uses a ghost-style base (transparent background).
/// - Applies an active background when [isActive] is true.
/// - Uses theme-aware hover background/foreground colors.
/// - Optionally enforces a [borderRadius] by setting a custom decoration.
///
/// Parameters:
/// - [baseStyle]: Optional base style to start from (defaults to `ButtonStyle.ghost()`).
/// - [isDarkMode]: Current theme mode flag (typically from [ThemeCubit]).
/// - [isActive]: Whether the button should appear selected/active.
/// - [activeBackgroundColor]: Background to use when active (also used on hover if active).
/// - [borderRadius]: Optional radius for rounded buttons.
///
/// Returns:
/// - An [AbstractButtonStyle] compatible with `shadcn_flutter` [Button].
AbstractButtonStyle lightButtonStyle({
  AbstractButtonStyle? baseStyle,
  required bool isDarkMode,
  required bool isActive,
  required Color activeBackgroundColor,
  double? borderRadius,
}) {
  final style = baseStyle ?? ButtonStyle.ghost();

  return style
      .copyWith(
        // If a border radius is provided, override decoration to apply it.
        decoration: borderRadius != null
            ? (context, states, value) {
                return BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                );
              }
            : null,
      )
      .withBackgroundColor(
        // Active buttons use a persistent background; inactive remain transparent.
        color: isActive ? activeBackgroundColor : null,

        // Hover: active stays active color; inactive gets a subtle hover tint.
        hoverColor: isActive
            ? activeBackgroundColor
            : isDarkMode
            ? Colors.gray[800]
            : Colors.blue[50],
      )
      .withForegroundColor(
        // Foreground (text/icon) colors are tuned for readability.
        color: isDarkMode ? Colors.gray[300] : Colors.gray[600],
        hoverColor: isDarkMode ? Colors.blue[400] : Colors.blue[900],
      );
}

/// A convenience wrapper around `shadcn_flutter` [Button] that applies [lightButtonStyle].
///
/// Use this when you need a consistent "subtle" button variant (navigation items,
/// small toolbar actions, etc.) while still supporting:
/// - leading/trailing widgets
/// - icon-only style via [isIcon]
/// - active/selected state via [isActive]
/// - optional custom alignment and border radius
///
/// Theme behavior:
/// - Reads [ThemeCubit] for dark/light mode.
/// - Chooses an active background that matches the current theme.
class LightButton extends StatelessWidget {
  /// Creates a themed light button.
  const LightButton({
    super.key,
    required this.child,
    required this.isIcon,
    this.onPressed,
    this.trailing,
    this.leading,
    this.borderRadius,
    this.isActive = false,
    this.alignment,
  });

  /// The button content (usually a [Text] widget).
  final Widget child;

  /// Optional trailing widget (e.g. chevron, badge).
  final Widget? trailing;

  /// Optional leading widget (e.g. icon).
  final Widget? leading;

  /// If true, uses the icon-optimized ghost style as base.
  final bool isIcon;

  /// Optional border radius override.
  final double? borderRadius;

  /// Tap/click handler.
  final void Function()? onPressed;

  /// Whether the button should be rendered in an active/selected state.
  final bool isActive;

  /// Optional alignment for the `Button` content.
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    // Use a different base style for icon-only buttons.
    final baseStyle = isIcon ? ButtonStyle.ghostIcon() : ButtonStyle.ghost();

    // Active background is theme-aware.
    final activeBackgroundColor = isDarkMode
        ? Colors.gray[900]
        : Colors.blue[100];

    return Button(
      style: lightButtonStyle(
        baseStyle: baseStyle,
        isDarkMode: isDarkMode,
        isActive: isActive,
        activeBackgroundColor: activeBackgroundColor,
        borderRadius: borderRadius,
      ),
      alignment: alignment,
      onPressed: onPressed,
      trailing: trailing,
      leading: leading,
      child: child,
    );
  }
}
