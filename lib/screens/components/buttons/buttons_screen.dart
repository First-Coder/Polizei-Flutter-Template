import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../extensions/text_extensions.dart';
import '../../widgets/code_card.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Gap(64),
        Text('Buttons').x5Large.h1.setColors(
          lightColor: Colors.gray[800],
          darkColor: Colors.white,
        ),
        Text(
          'Buttons ermöglichen es dem Benutzer, mit einem einzigen Klick \n'
          'Aktionen auszuführen und Entscheidungen zu treffen.',
          textAlign: TextAlign.center,
        ).x3Large.h1.setColors(
          lightColor: Colors.blue[800],
          darkColor: Colors.blue[400],
        ),
        Gap(64),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Primäre Buttons").x3Large.h1.setColors(
                    lightColor: Colors.gray[800],
                    darkColor: Colors.white,
                  ),
                ],
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Column(
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
                        Gap(10),
                      ],
                    ),
                  ).withPadding(horizontal: 20),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: CodeCard(
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
                        CodeTextLine("  child: const Text('Standard'),"),
                        CodeTextLine("),"),
                      ],
                    ),
                  ).withPadding(horizontal: 10),
                ],
              ),
            ],
          ),
        ),

        Gap(64),
      ],
    );
  }
}
