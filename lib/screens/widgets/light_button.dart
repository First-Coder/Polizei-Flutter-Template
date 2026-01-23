import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

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
        decoration: borderRadius != null
            ? (context, states, value) {
                return BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                );
              }
            : null,
      )
      .withBackgroundColor(
        color: isActive ? activeBackgroundColor : null,
        hoverColor: isActive
            ? activeBackgroundColor
            : isDarkMode
            ? Colors.gray[800]
            : Colors.blue[50],
      )
      .withForegroundColor(
        color: isDarkMode ? Colors.gray[300] : Colors.gray[600],
        hoverColor: isDarkMode ? Colors.blue[400] : Colors.blue[900],
      );
}

class LightButton extends StatelessWidget {
  const LightButton({
    super.key,
    required this.child,
    required this.isIcon,
    this.onPressed,
    this.trailing,
    this.leading,
    this.borderRadius,
    this.isActive = false,
  });

  final Widget child;

  final Widget? trailing;

  final Widget? leading;

  final bool isIcon;

  final double? borderRadius;

  final void Function()? onPressed;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    final baseStyle = isIcon ? ButtonStyle.ghostIcon() : ButtonStyle.ghost();
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
      onPressed: onPressed,
      trailing: trailing,
      leading: leading,
      child: child,
    );
  }
}
