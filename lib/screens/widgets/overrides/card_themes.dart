import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

class CardThemes extends StatelessWidget {
  const CardThemes({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    return ComponentTheme(
      data: CardTheme(fillColor: isDark ? Colors.gray[900] : Colors.white, filled: true, borderColor: isDark ? Colors.gray[700] : Colors.gray[200]),
      child: child,
    );
  }
}
