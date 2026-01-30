import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../extensions/text_extensions.dart';
import '../../../settings/error_settings.dart';
import '../../../theme/cubit/theme_cubit.dart';
import '../icon_container.dart';

class NotAuthorizedCard extends StatelessWidget {
  const NotAuthorizedCard({
    super.key,
    this.accessInformations,
    this.color,
    this.darkColor,
    this.withShadow = false,
  });

  final List<String>? accessInformations;

  final bool withShadow;

  final Color? color;

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
              color: Colors.orange[100],
              darkColor: Colors.orange[900].withAlpha(100),
              icon: LucideIcons.shieldAlert,
              iconColor: Colors.orange[600],
              iconDarkColor: Colors.orange[400],
            ),
            Gap(24),
            Text('403').bold.x8Large.setColors(
              lightColor: Colors.orange[600],
              darkColor: Colors.orange[400],
            ),
            Gap(8),
            Text('Zugriff verweigert').bold.x3Large.setColors(
              lightColor: Colors.gray[900],
              darkColor: Colors.white,
            ),
            Gap(16),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 440),
              child:
                  Text(
                    'Sie haben keine Berechtigung, auf diese Seite oder Ressource zuzugreifen.',
                    textAlign: TextAlign.center,
                  ).large.setColors(
                    lightColor: Colors.gray[600],
                    darkColor: Colors.gray[400],
                  ),
            ),
            Gap(24),
            SizedBox(
              width: double.infinity,
              child: Card(
                padding: EdgeInsets.all(24),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.orange[900].withAlpha(25)
                    : Colors.orange[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.lock,
                          color: isDarkMode
                              ? Colors.orange[400]
                              : Colors.orange[600],
                        ),
                        Gap(10),
                        Text('Zugriffsinformationen').h4.setColors(
                          lightColor: Colors.gray[900],
                          darkColor: Colors.white,
                        ),
                      ],
                    ),
                    Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (accessInformations ??
                                  ErrorSettings.accessInformations)
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
                      context.goNamed(ErrorSettings.accessInformationHomeLink),
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
