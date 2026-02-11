import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../extensions/text_extensions.dart';
import '../../../theme/cubit/theme_cubit.dart';

class AdditionalResources extends StatelessWidget {
  const AdditionalResources({super.key});

  /// Static list of resource cards displayed in the resource grid.
  final List<_ResourceCard> _resourceCards = const [
    _ResourceCard(
      icon: LucideIcons.book,
      title: "Dokumentation",
      text: "Vollständige Dokumentation aller Komponenten und Features",
      linkText: "Dokumentation öffnen",
      link: "https://sunarya-thito.github.io/shadcn_flutter/",
    ),
    _ResourceCard(
      icon: LucideIcons.code,
      title: "GitHub Repository",
      text: "Quellcode, Issues und Beiträge auf GitHub",
      linkText: "Zu Github",
      link: "https://github.com/First-Coder/Polizei-Flutter-Template",
    ),
    _ResourceCard(
      icon: LucideIcons.eye,
      title: "Live Demo",
      text: "Live Demo der Applikation",
      linkText: "Live Demo öffnen",
      link: "https://first-coder.github.io/Polizei-Flutter-Template/#/home",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return Container(
      width: double.infinity,
      color: isDarkMode ? Colors.gray[950] : Colors.gray[50],
      child: Column(
        children: [
          Text('Technologie Stack').bold.responsive(
            context,
            mobile: (t) => t.x3Large,
            tablet: (t) => t.x3Large,
            desktop: (t) => t.x4Large,
          ),
          Gap(16),
          Text(
            'Moderne und bewährte Technologien für beste Performance',
          ).setColors(
            lightColor: Colors.gray[600],
            darkColor: Colors.gray[400],
          ),
          Gap(48),
          Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 16.0;
                const minCardWidth = 200.0;
                const maxColumns = 3;

                final availableWidth = constraints.maxWidth;

                final columns =
                    ((availableWidth + spacing) / (minCardWidth + spacing))
                        .floor()
                        .clamp(1, maxColumns);

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _resourceCards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    mainAxisExtent: 210, // Breite/Höhe der Cards
                  ),
                  itemBuilder: (context, index) {
                    final card = _resourceCards[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              card.icon,
                              size: 32,
                              color: isDarkMode
                                  ? Colors.blue[400]
                                  : Colors.blue[900],
                            ),
                            const Gap(16),
                            Text(card.title).h4,
                            const Gap(6),
                            Flexible(
                              child: Text(
                                card.text,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ).muted.small,
                            ),
                            const Gap(12),
                            LinkButton(
                              density: ButtonDensity.compact,
                              child: Text(card.linkText),
                              onPressed: () async {
                                final uri = Uri.parse(card.link);
                                if (!await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  // TODO: Handle error with notification
                                  // throw Exception('Konnte URL nicht öffnen: $uri');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ).withPadding(vertical: 64),
    );
  }
}

/// Immutable data object used to render a ressource card.
class _ResourceCard {
  const _ResourceCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.linkText,
    required this.link,
  });

  /// Ressource icon.
  final IconData icon;

  /// Ressource title.
  final String title;

  /// Short ressource description.
  final String text;

  /// Ressource link text.
  final String linkText;

  /// Ressource link.
  final String link;
}
