import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

class Alert extends StatelessWidget {
  const Alert({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.backgroundColorDark,
    required this.borderColor,
    required this.borderColorDark,
    required this.borderRadius,
    required this.borderWidth,
  });

  Alert.basic({
    super.key,
    Widget? leading,
    Widget? trailing,
    Widget? titleWidget,
    String? title,
    Widget? contentWidget,
    String? content,
    required this.backgroundColor,
    required this.backgroundColorDark,
    required this.borderColor,
    required this.borderColorDark,
  }) : borderRadius = BorderRadius.circular(8),
       borderWidth = 4,
       child = Basic(
         leading: leading,
         trailing: trailing,
         title: titleWidget ?? Text(title ?? "No Text title").semiBold,
         content: contentWidget ?? Text(content ?? "No Text content").muted,
       );

  Alert.info({
    super.key,
    Widget? trailing,
    required String title,
    required String content,
  }) : borderRadius = BorderRadius.circular(8),
       borderWidth = 4,
       backgroundColor = Colors.blue[50],
       backgroundColorDark = Colors.blue[900].withAlpha(100),
       borderColor = Colors.blue[500],
       borderColorDark = Colors.blue[400],
       child = Basic(
         leading: Builder(
           builder: (context) {
             final isDark = context.watch<ThemeCubit>().state.isDarkMode;
             return Icon(
               LucideIcons.info,
               color: isDark ? Colors.blue[400] : Colors.blue[500],
             );
           },
         ),
         trailing: trailing,
         title: Text(title).semiBold,
         content: Text(content).muted,
       );

  Alert.success({
    super.key,
    Widget? trailing,
    required String title,
    required String content,
  }) : borderRadius = BorderRadius.circular(8),
       borderWidth = 4,
       backgroundColor = Colors.green[50],
       backgroundColorDark = Colors.green[900].withAlpha(100),
       borderColor = Colors.green[500],
       borderColorDark = Colors.green[400],
       child = Basic(
         leading: Builder(
           builder: (context) {
             final isDark = context.watch<ThemeCubit>().state.isDarkMode;
             return Icon(
               LucideIcons.circleCheck,
               color: isDark ? Colors.green[400] : Colors.green[500],
             );
           },
         ),
         trailing: trailing,
         title: Text(title).semiBold,
         content: Text(content).muted,
       );

  Alert.warning({
    super.key,
    Widget? trailing,
    required String title,
    required String content,
  }) : borderRadius = BorderRadius.circular(8),
        borderWidth = 4,
        backgroundColor = Colors.orange[50],
        backgroundColorDark = Colors.orange[900].withAlpha(100),
        borderColor = Colors.orange[500],
        borderColorDark = Colors.orange[400],
        child = Basic(
          leading: Builder(
            builder: (context) {
              final isDark = context.watch<ThemeCubit>().state.isDarkMode;
              return Icon(
                LucideIcons.circleAlert,
                color: isDark ? Colors.orange[400] : Colors.orange[500],
              );
            },
          ),
          trailing: trailing,
          title: Text(title).semiBold,
          content: Text(content).muted,
        );

  Alert.error({
    super.key,
    Widget? trailing,
    required String title,
    required String content,
  }) : borderRadius = BorderRadius.circular(8),
        borderWidth = 4,
        backgroundColor = Colors.red[50],
        backgroundColorDark = Colors.red[900].withAlpha(100),
        borderColor = Colors.red[500],
        borderColorDark = Colors.red[400],
        child = Basic(
          leading: Builder(
            builder: (context) {
              final isDark = context.watch<ThemeCubit>().state.isDarkMode;
              return Icon(
                LucideIcons.circleX,
                color: isDark ? Colors.red[400] : Colors.red[500],
              );
            },
          ),
          trailing: trailing,
          title: Text(title).semiBold,
          content: Text(content).muted,
        );

  final Widget child;

  final Color backgroundColor;

  final Color backgroundColorDark;

  final Color borderColor;

  final Color borderColorDark;

  final BorderRadius borderRadius;

  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark : backgroundColor,
        borderRadius: borderRadius,
        border: Border(
          left: BorderSide(
            color: isDark ? borderColorDark : borderColor,
            width: borderWidth,
          ),
        ),
      ),
      child: child.withPadding(all: 24),
    );
  }
}
