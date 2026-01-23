import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

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
    final style = isIcon ? ButtonStyle.ghostIcon() : ButtonStyle.ghost();
    final activeBackgroundColor = isDarkMode
        ? Colors.gray[900]
        : Colors.blue[100];
    return Button(
      style: style
          .copyWith(
            decoration: borderRadius != null
                ? (context, states, value) {
                    return BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
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
          ),
      onPressed: onPressed,
      trailing: trailing,
      leading: leading,
      child: child,
    );
  }
}
