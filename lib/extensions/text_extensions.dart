import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/screens/widgets/layouts/responsive.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../theme/cubit/theme_cubit.dart';

/// Extension providing text styling modifiers for Text.
extension TextExtension on Widget {
  /// Set the text color based on the current theme.
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

  /// Set responsive elements based on the screen
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
