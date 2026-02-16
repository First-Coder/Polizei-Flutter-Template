import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

/// A small, reusable circular container for displaying an icon with themed colors.
///
/// Common use cases:
/// - Error/info cards (e.g. 404/403/500 pages)
/// - Feature highlights
/// - Empty states
///
/// Theme behavior:
/// - Reads [ThemeCubit] to determine whether the app is in dark mode.
/// - If [darkColor] is provided and dark mode is active, it is used as background.
/// - If [iconDarkColor] is provided and dark mode is active, it is used for the icon.
///
/// Notes:
/// - The container uses a very large border radius (`999`) to achieve a circle.
/// - Defaults ([width], [height], [iconSize]) are tuned for card headers.
class IconContainer extends StatelessWidget {
  /// Creates an icon container.
  const IconContainer({
    super.key,
    this.width = 96,
    this.height = 96,
    required this.color,
    this.darkColor,
    required this.icon,
    this.iconSize = 48,
    required this.iconColor,
    this.iconDarkColor,
  });

  /// Container width (logical pixels).
  final double width;

  /// Container height (logical pixels).
  final double height;

  /// Background color used in light mode (and as fallback in dark mode).
  final Color color;

  /// Optional background color used in dark mode.
  final Color? darkColor;

  /// Icon glyph to display.
  final IconData icon;

  /// Icon size (logical pixels).
  final double iconSize;

  /// Icon color used in light mode (and as fallback in dark mode).
  final Color iconColor;

  /// Optional icon color used in dark mode.
  final Color? iconDarkColor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    final backgroundColor = (darkColor != null && isDarkMode)
        ? darkColor
        : color;
    final effectiveIconColor = (iconDarkColor != null && isDarkMode)
        ? iconDarkColor
        : iconColor;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Icon(
        icon,
        // Keep size customizable; default is 48.
        size: iconSize,
        color: effectiveIconColor,
      ),
    );
  }
}
