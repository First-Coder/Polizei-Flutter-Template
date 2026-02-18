import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widgets/code_card.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 752),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Card Komponente verwenden').h3,
          CodeCard(
            title: "Basis Card",
            example: SizedBox(
              width: double.infinity,
              child: Card(
                child: Basic(
                  title: Text('Basis Card').base,
                  subtitle: Text(
                    'Eine einfache Card-Komponente mit Titel und Text.',
                  ).small,
                  titleSpacing: 20,
                  content: LinkButton(
                    density: ButtonDensity.compact,
                    onPressed: () {},
                    trailing: Icon(LucideIcons.arrowRight),
                    child: Text('Mehr erfahren'),
                  ),
                ),
              ),
            ),
            lines: [
              CodeTextLine("Card("),
              CodeTextLine("  child: Basic("),
              CodeTextLine("    title: Text('Basis Card').base,"),
              CodeTextLine("    subtitle: Text("),
              CodeTextLine(
                "      'Eine einfache Card-Komponente mit Titel und Text.'",
              ),
              CodeTextLine("    ).small,"),
              CodeTextLine("    titleSpacing: 20,"),
              CodeTextLine("    content: LinkButton("),
              CodeTextLine("      density: ButtonDensity.compact,"),
              CodeTextLine("      onPressed: () {},"),
              CodeTextLine("      trailing: Icon(LucideIcons.arrowRight),"),
              CodeTextLine("      child: Text('Mehr erfahren'),"),
              CodeTextLine("    ),"),
              CodeTextLine("  ),"),
              CodeTextLine(");"),
            ],
          ),
          CodeCard(
            title: "Basis Card mit Icon",
            example: SizedBox(
              width: double.infinity,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconContainer(icon: Icon(LucideIcons.info)),
                    Basic(
                      title: Text('Basis Card').base,
                      subtitle: Text(
                        'Eine einfache Card-Komponente mit Titel und Text.',
                      ).small,
                      titleSpacing: 20,
                      content: LinkButton(
                        density: ButtonDensity.compact,
                        onPressed: () {},
                        trailing: Icon(LucideIcons.arrowRight),
                        child: Text('Mehr erfahren'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            lines: [
              CodeTextLine("Card("),
              CodeTextLine("  child: Basic("),
              CodeTextLine("    title: Text('Basis Card').base,"),
              CodeTextLine("    subtitle: Text("),
              CodeTextLine(
                "      'Eine einfache Card-Komponente mit Titel und Text.'",
              ),
              CodeTextLine("    ).small,"),
              CodeTextLine("    titleSpacing: 20,"),
              CodeTextLine("    content: LinkButton("),
              CodeTextLine("      density: ButtonDensity.compact,"),
              CodeTextLine("      onPressed: () {},"),
              CodeTextLine("      trailing: Icon(LucideIcons.arrowRight),"),
              CodeTextLine("      child: Text('Mehr erfahren'),"),
              CodeTextLine("    ),"),
              CodeTextLine("  ),"),
              CodeTextLine(");"),
            ],
          ),
        ],
      ).gap(15).withPadding(vertical: 30),
    ).withPadding(horizontal: 20);
  }
}
