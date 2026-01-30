import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/screens/widgets/error_pages/internal_server_error_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';
import '../widgets/layouts/full_screen_layout.dart';

class InternalServerErrorScreen extends StatelessWidget {
  const InternalServerErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return FullScreenLayout(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [Colors.gray[900], Colors.gray[950]]
              : [Colors.red[50], Colors.gray[100]],
        ),
      ),
      children: [
        InternalServerErrorCard(
          withShadow: true,
          color: Colors.red[300],
          darkColor: Colors.red[900].withAlpha(127),
        ),
      ],
    );
  }
}
