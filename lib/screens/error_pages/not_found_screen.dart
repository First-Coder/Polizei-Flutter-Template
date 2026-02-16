import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/screens/widgets/error_pages/not_found_card.dart';
import 'package:police_flutter_template/screens/widgets/layouts/full_screen_layout.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';

/// Full-screen "Not Found" (typically HTTP 404) error page.
///
/// This screen:
/// - Uses [ThemeCubit] to adapt the background gradient for light/dark mode.
/// - Wraps its content in [FullScreenLayout] to provide a consistent header/footer.
/// - Displays a [NotFoundCard] as the main content.
class NotFoundScreen extends StatelessWidget {
  /// Creates a "Not Found" error page.
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the current theme mode from the theme cubit.
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    return FullScreenLayout(
      decoration: BoxDecoration(
        // Theme-aware gradient to keep the screen visually consistent.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [Colors.gray[900], Colors.gray[950]]
              : [Colors.blue[50], Colors.gray[100]],
        ),
      ),
      children: [
        // Main error content card.
        NotFoundCard(
          withShadow: true,
          color: Colors.gray[300],
          darkColor: Colors.gray[600],
        ),
      ],
    );
  }
}
