import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/screens/widgets/error_pages/not_authorized_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';
import '../widgets/layouts/full_screen_layout.dart';

class NotAuthorizedScreen extends StatelessWidget {
  const NotAuthorizedScreen({super.key});

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
              : [Colors.orange[50], Colors.orange[100]],
        ),
      ),
      children: [
        NotAuthorizedCard(
          withShadow: true,
          color: Colors.orange[300],
          darkColor: Colors.orange[600],
        ),
      ],
    );
  }
}
