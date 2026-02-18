import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../extensions/text_extensions.dart';
import '../../widgets/code_card.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Gap(64),
        Text('Formular-Elemente').h3.setColors(
          lightColor: Colors.gray[800],
          darkColor: Colors.white,
        ),
        Gap(50),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 900),
                    child: CodeCard(
                      title: 'Primäre Buttons',
                      example: Row(
                        children: [
                          PrimaryButton(
                            onPressed: () {},
                            child: const Text('Standard'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            leading: const Icon(LucideIcons.download),
                            onPressed: () {},
                            child: const Text('Mit Icon vorne'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            trailing: const Icon(LucideIcons.arrowRight),
                            onPressed: () {},
                            child: const Text('Mit Icon hinten'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            child: const Text('Deaktiviert'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Primäre Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeCommentLine("  # Mit Icon vorne"),
                        CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                        CodeCommentLine("  # Mit Icon hinten"),
                        CodeTextLine("  trailing: const Icon(LucideIcons.arrowRight),"),
                        CodeCommentLine("  # Für aktiven Button (bei deaktiviertem Button weglassen)"),
                        CodeTextLine("  onPressed: () {},"),
                        CodeCommentLine("  # Text des Buttons"),
                        CodeTextLine("  child: const Text('Primärer Button'),"),
                        CodeTextLine("),"),
                      ],
                    ),
                  ).withPadding(horizontal: 10),
                ],
              ),
              Gap(20),
            ],
          ),
        ),

        Gap(64),
      ],
    );
  }
}
