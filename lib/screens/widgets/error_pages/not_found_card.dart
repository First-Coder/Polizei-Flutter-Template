import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:police_flutter_template/settings/error_settings.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

/// A reusable card widget for displaying a "Not Found" (HTTP 404) page section.
///
/// Intended usage:
/// - Embedded into a full-screen error page layout (e.g. `NotFoundScreen`)
/// - Can also be used in other layouts as a standalone "missing content" component
///
/// Features:
/// - Theme-aware rendering using [ThemeCubit].
/// - Optional custom border colors via [color] and [darkColor].
/// - Optional drop shadow via [withShadow].
/// - Configurable list of bullet points via [possibleReasons], with fallback to
///   [ErrorSettings.notFoundReasons].
///
/// Navigation:
/// - Provides a "Back" action using `context.pop()` (enabled only if `canPop()`).
/// - Provides a "Go to home" action using `context.goNamed(...)` configured by
///   [ErrorSettings.notFoundHomeLink].
///
/// Note:
/// - User-facing copy is German; consider i18n if needed.
class NotFoundCard extends StatelessWidget {
  const NotFoundCard({
    super.key,
    this.possibleReasons,
    this.color,
    this.darkColor,
    this.withShadow = false,
  });

  /// Optional list of user-facing reasons (displayed as bullet points).
  ///
  /// If null, falls back to [ErrorSettings.notFoundReasons].
  final List<String>? possibleReasons;

  /// Whether to show a large soft shadow around the card.
  final bool withShadow;

  /// Optional border color used in light mode.
  final Color? color;

  /// Optional border color used in dark mode.
  final Color? darkColor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 720),
      child: Card(
        boxShadow: withShadow
            ? [
                isDarkMode
                    ? BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.25),
                        offset: Offset(0, 0),
                        blurRadius: 50,
                        spreadRadius: -12,
                      )
                    : BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 0),
                        blurRadius: 50,
                        spreadRadius: -12,
                      ),
              ]
            : null,
        borderColor: isDarkMode ? darkColor : color,
        borderWidth: 2,
        child: Column(
          children: [
            IconContainer(
              icon: Icon(LucideIcons.fileQuestion, size: 48),
              backgroundColor: isDarkMode
                  ? Colors.blue[900].withAlpha(100)
                  : Colors.blue[100],
              iconColor: isDarkMode ? Colors.blue[400] : Colors.blue[900],
              borderRadius: BorderRadius.circular(999),
              padding: EdgeInsets.all(24),
            ),
            Gap(24),
            Text('404').bold.x8Large.setColors(
              lightColor: Colors.blue[900],
              darkColor: Colors.blue[400],
            ),
            Gap(8),
            Text('Seite nicht gefunden').bold.x3Large.setColors(
              lightColor: Colors.gray[900],
              darkColor: Colors.white,
            ),
            Gap(16),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 440),
              child:
                  Text(
                    'Die von Ihnen gesuchte Seite existiert nicht oder wurde verschoben.',
                    textAlign: TextAlign.center,
                  ).large.setColors(
                    lightColor: Colors.gray[600],
                    darkColor: Colors.gray[400],
                  ),
            ),
            Gap(24),

            // Reasons section.
            SizedBox(
              width: double.infinity,
              child: Card(
                padding: EdgeInsets.all(24),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.blue[900].withAlpha(25)
                    : Colors.blue[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mögliche Gründe:').semiBold.setColors(
                      lightColor: Colors.gray[900],
                      darkColor: Colors.white,
                    ),
                    Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (possibleReasons ?? ErrorSettings.notFoundReasons)
                              .map(
                                (reason) => Text(reason).li.setColors(
                                  lightColor: Colors.gray[600],
                                  darkColor: Colors.gray[400],
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
            ).withPadding(horizontal: 30),

            Gap(32),

            // Primary actions.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlineButton(
                  onPressed: () => context.pop(),
                  enabled: context.canPop(),
                  leading: const Icon(LucideIcons.arrowLeft),
                  child: Text('Zurück'),
                ),
                PrimaryButton(
                  onPressed: () =>
                      context.goNamed(ErrorSettings.notFoundHomeLink),
                  leading: const Icon(LucideIcons.house),
                  child: Text('Zur Startseite'),
                ),
              ],
            ).gap(10),

            Divider().withPadding(all: 32),
            Text('Benötigen Sie Hilfe? Kontaktieren Sie uns.').muted.small,
          ],
        ).withPadding(vertical: 48),
      ),
    );
  }
}
