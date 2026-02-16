import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:police_flutter_template/screens/widgets/icon_container.dart';
import 'package:police_flutter_template/settings/error_settings.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide IconContainer;

import '../../../theme/cubit/theme_cubit.dart';

class NotFoundCard extends StatelessWidget {
  const NotFoundCard({
    super.key,
    this.possibleReasons,
    this.color,
    this.darkColor,
    this.withShadow = false,
  });

  final List<String>? possibleReasons;

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
              color: Colors.blue[100],
              darkColor: Colors.blue[900].withAlpha(100),
              icon: LucideIcons.fileQuestion,
              iconColor: Colors.blue[900],
              iconDarkColor: Colors.blue[400],
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
