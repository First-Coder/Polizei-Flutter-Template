import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

class TabThemes extends StatelessWidget {
  const TabThemes({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    return ComponentTheme(
      data: TabListTheme(
        borderColor: isDark ? Colors.gray[400] : Colors.blue[900],
        borderWidth: 1,
        indicatorColor: isDark ? Colors.gray[400] : Colors.blue[900],
        indicatorHeight: 3,
      ),
      child: ComponentTheme(
        data: TabsTheme(
          backgroundColor: isDark ? Colors.gray[600] : Colors.blue[100],
        ),
        child: child,
      ),
    );
  }
}
