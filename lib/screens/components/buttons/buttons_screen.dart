import 'package:police_flutter_template/screens/widgets/code_block.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: PrimaryButton(
                onPressed: () {},
                child: const Text('Primärer Button'),
              ),
            ).withPadding(horizontal: 20),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: CodeBlock(
                lines: [
                  CodeCommentLine("# Beispiel für Primären Button"),
                  CodeTextLine(
                    "PrimaryButton(",
                  ),
                  CodeTextLine("  onPressed: () {},"),
                  CodeTextLine("  child: const Text('Primärer Button'),"),
                  CodeTextLine("),"),
                ],
              ),
            ).withPadding(horizontal: 10),
          ],
        ),

        Gap(64),
      ],
    );
  }
}
