import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

class IconContainer extends StatelessWidget {
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

  final double width;

  final double height;

  final Color color;

  final Color? darkColor;

  final IconData icon;

  final double iconSize;

  final Color iconColor;

  final Color? iconDarkColor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: darkColor != null && isDarkMode ? darkColor : color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Icon(
        LucideIcons.fileQuestion,
        size: 48,
        color: darkColor != null && isDarkMode ? iconDarkColor : iconColor,
      ),
    );
  }
}
