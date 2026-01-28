import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/screens/widgets/error_pages/not_found_card.dart';
import 'package:police_flutter_template/screens/widgets/layouts/full_screen_layout.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

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
              : [Colors.blue[50], Colors.gray[100]],
        ),
      ),
      children: [NotFoundCard(withShadow: true)],
    );
  }
}
