import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/screens/widgets/error_pages/not_authorized_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../theme/cubit/theme_cubit.dart';
import '../widgets/layouts/full_screen_layout.dart';

/// Full-screen "Not Authorized" (typically HTTP 403) error page.
///
/// This screen:
/// - Uses [ThemeCubit] to adapt the background gradient for light/dark mode.
/// - Wraps its content in [FullScreenLayout] to provide a consistent header/footer.
/// - Displays a [NotAuthorizedCard] as the main content.
class NotAuthorizedScreen extends StatelessWidget {
  /// Creates a "Not Authorized" error page.
  const NotAuthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the current theme mode from the theme cubit.
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    return FullScreenLayout(
      decoration: BoxDecoration(
        // Background gradient is theme-aware to keep the error page readable and consistent.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [Colors.gray[900], Colors.gray[950]]
              : [Colors.orange[50], Colors.orange[100]],
        ),
      ),
      children: [
        // Main error content card.
        NotAuthorizedCard(
          withShadow: true,
          color: Colors.orange[300],
          darkColor: Colors.orange[600],
        ),
      ],
    );
  }
}
