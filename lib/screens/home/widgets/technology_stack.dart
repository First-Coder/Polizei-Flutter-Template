import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../extensions/text_extensions.dart';
import '../../../theme/cubit/theme_cubit.dart';

class TechnologyStack extends StatelessWidget {
  const TechnologyStack({super.key});

  /// Static list of feature cards displayed in the hero grid.
  final List<_StackCard> _heroCards = const [
    _StackCard(title: "Flutter", text: "aktueller Stable-Channel empfohlen"),
    _StackCard(title: "State Management", text: "flutter_bloc, equatable"),
    _StackCard(title: "Routing", text: "go_router"),
    _StackCard(title: "Networking", text: "dio"),
    _StackCard(title: "Dependency Injection", text: "get_it"),
    _StackCard(title: "Secure Storage", text: "flutter_secure_storage"),
    _StackCard(
      title: "Logging/Observability",
      text: "talker_flutter, talker_bloc_logger, talker_dio_logger",
    ),
    _StackCard(
      title: "UI",
      text: "shadcn_flutter, flutter_svg, flutter_animate, flutter_spinkit",
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
                const maxColumns = 6;

                final availableWidth = constraints.maxWidth;

                final columns =
                    ((availableWidth + spacing) / (minCardWidth + spacing))
                        .floor()
                        .clamp(1, maxColumns);

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _heroCards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    mainAxisExtent: 210, // Breite/Höhe der Cards
                  ),
                  itemBuilder: (context, index) {
                    final card = _heroCards[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.package,
                              size: 32,
                              color: isDarkMode
                                  ? Colors.blue[400]
                                  : Colors.blue[900],
                            ),
                            const Gap(12),
                            Text(card.title, textAlign: TextAlign.center).h4,
                            const Gap(6),
                            Flexible(
                              child: Text(
                                card.text,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ).muted.small,
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

/// Immutable data object used to render a single hero feature card.
class _StackCard {
  const _StackCard({required this.title, required this.text});

  /// Feature title.
  final String title;

  /// Short feature description.
  final String text;
}
