import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../extensions/text_extensions.dart';
import '../../../settings/error_settings.dart';
import '../../../theme/cubit/theme_cubit.dart';

/// A reusable card widget for displaying an "Internal Server Error" (HTTP 500) page section.
///
/// Intended usage:
/// - Embedded into a full-screen error page layout (e.g. `InternalServerErrorScreen`)
/// - Can also be used inside other layouts as a standalone error component.
///
/// Features:
/// - Theme-aware coloring and shadows using [ThemeCubit].
/// - Optional custom border colors via [color] and [darkColor].
/// - Optional drop shadow via [withShadow] for prominent standalone display.
/// - Configurable copy lists:
///   - [whatHappend] (what went wrong)
///   - [help] (what the user can do)
///
/// Defaults:
/// - If [whatHappend] / [help] are not provided, values are taken from [ErrorSettings].
///
/// Navigation:
/// - Provides a "Back" action using `context.pop()` (enabled only if `canPop()`).
/// - Provides a "Go to home" action using `context.goNamed(...)` configured by
///   [ErrorSettings.internalServerErrorHomeLink].
///
/// Note:
/// - Some user-facing text is German; consider i18n if needed.
class InternalServerErrorCard extends StatelessWidget {
  const InternalServerErrorCard({
    super.key,
    this.whatHappend,
    this.help,
    this.color,
    this.darkColor,
    this.withShadow = false,
  });

  /// Optional list describing what happened (displayed as bullet points).
  final List<String>? whatHappend;

  /// Optional list describing recommended user actions to recover.
  final List<String>? help;

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
              icon: Icon(LucideIcons.serverCrash, size: 48),
              backgroundColor: isDarkMode
                  ? Colors.red[900].withAlpha(50)
                  : Colors.red[100],
              iconColor: isDarkMode ? Colors.red[400] : Colors.red[600],
              borderRadius: BorderRadius.circular(999),
              padding: EdgeInsets.all(24),
            ),
            Gap(24),
            Text('500').bold.x8Large.setColors(
              lightColor: Colors.red[600],
              darkColor: Colors.red[400],
            ),
            Gap(8),
            Text('Interner Serverfehler').bold.x3Large.setColors(
              lightColor: Colors.gray[900],
              darkColor: Colors.white,
            ),
            Gap(16),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 440),
              child:
                  Text(
                    'Es ist ein unerwarteter Fehler aufgetreten. Unser Team wurde automatisch benachrichtigt.',
                    textAlign: TextAlign.center,
                  ).large.setColors(
                    lightColor: Colors.gray[600],
                    darkColor: Colors.gray[400],
                  ),
            ),
            Gap(24),

            // "What happened?" section.
            SizedBox(
              width: double.infinity,
              child: Card(
                padding: EdgeInsets.all(24),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.red[900].withAlpha(25)
                    : Colors.red[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.triangleAlert,
                          color: isDarkMode ? Colors.red[400] : Colors.red[600],
                        ),
                        Gap(10),
                        Text('Was ist passiert?').h4.setColors(
                          lightColor: Colors.gray[900],
                          darkColor: Colors.white,
                        ),
                      ],
                    ),
                    Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (whatHappend ?? ErrorSettings.accessInformations)
                              .map(
                                (reason) => Text(reason).li.setColors(
                                  lightColor: Colors.gray[600],
                                  darkColor: Colors.gray[400],
                                ),
                              )
                              .toList(),
                    ).gap(5),
                  ],
                ),
              ),
            ).withPadding(horizontal: 30),

            Gap(32),

            // "What can you do?" section.
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
                    Text('Was können Sie tun?').center().h4.setColors(
                      lightColor: Colors.gray[900],
                      darkColor: Colors.white,
                    ),
                    Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (whatHappend ?? ErrorSettings.accessInformations)
                              .map(
                                (reason) => Row(
                                  children: [
                                    Icon(
                                      LucideIcons.check,
                                      color: isDarkMode
                                          ? Colors.blue[400]
                                          : Colors.blue[600],
                                    ),
                                    Text(reason).setColors(
                                      lightColor: Colors.gray[600],
                                      darkColor: Colors.gray[400],
                                    ),
                                  ],
                                ).gap(10),
                              )
                              .toList(),
                    ).gap(5),
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
                  onPressed: () => context.goNamed(
                    ErrorSettings.internalServerErrorHomeLink,
                  ),
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
