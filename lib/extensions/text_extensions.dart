import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/screens/widgets/layouts/responsive.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../theme/cubit/theme_cubit.dart';

/// Text- and layout-related widget extensions used throughout the app.
///
/// Although the extension is declared on [Widget], it is primarily meant for:
/// - text widgets such as `Text(...)` (because it returns a [TextModifier])
/// - small responsive UI transformations that wrap the widget
///
/// Key features:
/// - Theme-aware text coloring via [ThemeCubit]
/// - Simple breakpoint-based widget transformation via `Responsive`
extension TextExtension on Widget {
  /// Applies theme-aware text color styling to the wrapped widget.
  ///
  /// - In light mode, [lightColor] is used.
  /// - In dark mode, [darkColor] is used if provided; otherwise [lightColor] is reused.
  ///
  /// This returns a [TextModifier] (from `shadcn_flutter`) which can be chained
  /// with other text modifiers.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello')
  ///   .bold
  ///   .setColors(lightColor: Colors.black, darkColor: Colors.white);
  /// ```
  TextModifier setColors({required Color lightColor, Color? darkColor}) =>
      WrappedText(
        style: (context, theme) {
          if (darkColor == null) {
            return TextStyle(color: lightColor);
          }
          final isDark = context.watch<ThemeCubit>().state.isDarkMode;
          return TextStyle(color: isDark ? darkColor : lightColor);
        },
        child: this,
      );

  /// Applies a responsive transformation based on the current screen size.
  ///
  /// This is a lightweight helper that selects the first matching transformer:
  /// - [desktop] when `Responsive.isDesktop(context)`
  /// - [tablet] when `Responsive.isTablet(context)`
  /// - [mobile] when `Responsive.isMobile(context)`
  ///
  /// If no transformer matches (or is provided), returns `this` unchanged.
  ///
  /// Example:
  /// ```dart
  /// Text('Title').responsive(
  ///   context,
  ///   mobile: (w) => w.xLarge,
  ///   desktop: (w) => w.x3Large,
  /// );
  /// ```
  Widget responsive(
    BuildContext context, {
    Widget Function(Widget widget)? mobile,
    Widget Function(Widget widget)? tablet,
    Widget Function(Widget widget)? desktop,
  }) {
    if (Responsive.isDesktop(context) && desktop != null) {
      return desktop(this);
    }

    if (Responsive.isTablet(context) && tablet != null) {
      return tablet(this);
    }

    if (Responsive.isMobile(context) && mobile != null) {
      return mobile(this);
    }

    return this;
  }
}
