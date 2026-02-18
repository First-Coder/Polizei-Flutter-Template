import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Immutable data model for a single entry in [IconList].
///
/// This model is designed for "feature / action / info" rows that are rendered with:
/// - a leading icon inside an `IconContainer`
/// - a [title] (primary label)
/// - a [subtitle] (secondary label)
///
/// Theme-aware colors:
/// - You can provide separate colors for light and dark mode.
/// - The list widget decides which one to apply by reading the current theme state.
///
/// Notes:
/// - If you leave a color as `null`, the corresponding `IconContainer` property
///   will also be `null` (so the widget/library defaults can apply).
/// - This model contains no interaction logic; handle taps/actions in the widget
///   that consumes the model list.
class IconListModel {
  /// Creates a display-only icon list item.
  const IconListModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor,
    this.iconColorDark,
    this.color,
    this.colorDark,
  });

  /// The icon shown in the leading `IconContainer`.
  final IconData icon;

  /// Primary text shown for the item.
  final String title;

  /// Secondary text shown below/next to the title.
  final String subtitle;

  /// Foreground/icon color used in light mode (optional).
  ///
  /// If `null`, the default icon color from the component/theme is used.
  final Color? iconColor;

  /// Foreground/icon color used in dark mode (optional).
  ///
  /// Typically pick a slightly brighter color than [iconColor] for contrast.
  final Color? iconColorDark;

  /// Background color for the `IconContainer` in light mode (optional).
  final Color? color;

  /// Background color for the `IconContainer` in dark mode (optional).
  ///
  /// Typically pick a slightly darker/more muted variant of [color].
  final Color? colorDark;
}
