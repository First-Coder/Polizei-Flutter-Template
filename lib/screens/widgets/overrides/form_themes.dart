import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

class FormThemes extends StatelessWidget {
  const FormThemes({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    return ComponentTheme(
      data: CheckboxTheme(
        backgroundColor: isDark ? Colors.gray[800] : Colors.white,
        activeColor: isDark ? Colors.gray[500] : Colors.blue[900],
        borderColor: isDark ? Colors.gray[100] : Colors.blue[900],
      ),
      child: ComponentTheme(
        data: RadioTheme(
          backgroundColor: isDark ? Colors.gray[800] : Colors.white,
          activeColor: isDark ? Colors.gray[400] : Colors.blue[900],
          borderColor: isDark ? Colors.gray[100] : Colors.blue[900],
        ),
        child: ComponentTheme(
          data: RadioCardTheme(
            color: isDark ? Colors.gray[800] : Colors.white,
            hoverColor: isDark ? Colors.gray[500] : Colors.blue[200],
            borderColor: isDark ? Colors.gray[300] : Colors.blue[900],
            selectedBorderColor: isDark ? Colors.gray[100] : Colors.blue[900],
            selectedBorderWidth: 3,
          ),
          child: ComponentTheme(
            data: SliderTheme(
              trackColor: isDark ? Colors.gray[500] : Colors.blue[200],
              valueColor: isDark ? Colors.gray[100] : Colors.blue[900],
              thumbColor: isDark ? Colors.gray[100] : Colors.blue[900],
              thumbBorderColor: isDark ? Colors.blue[900] : Colors.blue[900],
            ),
            child: ComponentTheme(
              data: SwitchTheme(
                activeColor: isDark ? Colors.blue[400] : Colors.blue[300],
                activeThumbColor: isDark ? Colors.blue[900] : Colors.blue[900],
                inactiveColor: isDark ? Colors.gray[500] : Colors.gray[200],
                inactiveThumbColor: isDark ? Colors.gray[200] : Colors.blue[900],
              ),
              child: ComponentTheme(
                data: MenuButtonTheme(
                  decoration: (context, states, defaultDecoration) {
                    var themeData = Theme.of(context);
                    if (states.contains(WidgetState.hovered)) {
                      return BoxDecoration(
                        color: themeData.colorScheme.muted.scaleAlpha(0.8),
                        borderRadius: BorderRadius.circular(themeData.radiusMd),
                      );
                    }
                    return BoxDecoration(
                      color: themeData.colorScheme.muted.withValues(alpha: 0),
                      borderRadius: BorderRadius.circular(themeData.radiusMd),
                    );
                  },
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
