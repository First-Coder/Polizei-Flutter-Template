import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/extensions/button_extensions.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

class LightButton extends StatefulWidget {
  const LightButton({
    super.key,
    required this.child,
    required this.isIcon,
    this.onPressed,
    this.trailing,
    this.leading,
    this.borderRadius,
  });

  final Widget child;

  final Widget? trailing;

  final Widget? leading;

  final bool isIcon;

  final double? borderRadius;

  final void Function()? onPressed;

  @override
  State<LightButton> createState() => _LightButtonState();
}

class _LightButtonState extends State<LightButton> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return Button(
      style: widget.isIcon
          ? ButtonStyle.ghostIcon()
                .copyWith(
                  decoration: widget.borderRadius != null
                      ? (context, states, value) {
                          return BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          );
                        }
                      : null,
                )
                .withBackgroundColor(
                  hoverColor: isDarkMode ? Colors.gray[800] : Colors.blue[50],
                )
                .withForegroundColor(
                  color: isDarkMode ? Colors.gray[300] : Colors.gray[600],
                  hoverColor: isDarkMode ? Colors.blue[400] : Colors.blue[900],
                )
          : ButtonStyle.ghost()
                .copyWith(
                  decoration: widget.borderRadius != null
                      ? (context, states, value) {
                          return BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          );
                        }
                      : null,
                )
                .withBackgroundColor(
                  hoverColor: isDarkMode ? Colors.gray[800] : Colors.blue[50],
                )
                .withForegroundColor(
                  color: isDarkMode ? Colors.gray[300] : Colors.gray[600],
                  hoverColor: isDarkMode ? Colors.blue[400] : Colors.blue[900],
                ),
      onPressed: widget.onPressed,
      trailing: widget.trailing,
      leading: widget.leading,
      child: widget.child,
    );
  }
}
