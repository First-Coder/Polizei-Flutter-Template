import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

class ContainerThemes extends StatelessWidget {
  const ContainerThemes({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    return ComponentTheme(
      data: IconContainerTheme(

      ),
      child: child,
    );
  }
}
