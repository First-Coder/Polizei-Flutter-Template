import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/screens/widgets/error_pages/internal_server_error_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';
import '../widgets/layouts/full_screen_layout.dart';

/// Full-screen "Internal Server Error" (typically HTTP 500) error page.
///
/// This screen:
/// - Uses [ThemeCubit] to adapt the background gradient for light/dark mode.
/// - Wraps its content in [FullScreenLayout] to provide a consistent header/footer.
/// - Displays an [InternalServerErrorCard] as the main content.
class InternalServerErrorScreen extends StatelessWidget {
  /// Creates an "Internal Server Error" page.
  const InternalServerErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the current theme mode from the theme cubit.
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    return FullScreenLayout(
      decoration: BoxDecoration(
        // Red-ish gradient for error emphasis; still theme-aware.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [Colors.gray[900], Colors.gray[950]]
              : [Colors.red[50], Colors.gray[100]],
        ),
      ),
      children: [
        // Main error content card.
        InternalServerErrorCard(
          withShadow: true,
          color: Colors.red[300],
          darkColor: Colors.red[900].withAlpha(127),
        ),
      ],
    );
  }
}
