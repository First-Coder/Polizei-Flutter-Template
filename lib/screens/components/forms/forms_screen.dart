import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../extensions/text_extensions.dart';
import '../../widgets/code_card.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameKey = const TextFieldKey('name'); // TextField → String
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
                      title: 'Text-Eingaben',
                      example: Row(
                        children: [
                          SizedBox(
                            width: 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FormField<String>(
                                  key: nameKey,
                                  label: const Text('Text-Feld'),
                                  validator: const LengthValidator(min: 2),
                                  child: const TextField(
                                    placeholder: Text('Ihr Text ...'),
                                    initialValue: '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Text-Eingabefelder"),
                        CodeTextLine("SizedBox("),
                        CodeCommentLine("  # Für die Einschränkung in der Breite"),
                        CodeTextLine("  width: 500,"),
                        CodeTextLine("  child: Column("),
                        CodeTextLine("    crossAxisAlignment: CrossAxisAlignment.stretch,"),
                        CodeTextLine("    children: ["),
                        CodeTextLine("      FormField<String>("),
                        CodeTextLine("        key: nameKey,"),
                        CodeTextLine("        label: const Text('Text-Feld'),"),
                        CodeTextLine("        validator: const LengthValidator(min: 2),"),
                        CodeTextLine("        child: const TextField("),
                        CodeTextLine("          placeholder: Text('Ihr Text ...'),"),
                        CodeTextLine("          initialValue: '',"),
                        CodeTextLine("        ),"),
                        CodeTextLine("      ),"),
                        CodeCommentLine("      # Hier können weitere Komponenten eingefügt werden"),
                        CodeTextLine("    ],"),
                        CodeTextLine("  ),"),
                        CodeTextLine("),"),
                      ],
                    ),
                  ).withPadding(horizontal: 10),
                ],
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 900),
                    child: CodeCard(
                      title: 'Text-Eingaben',
                      example: Row(
                        children: [
                          SizedBox(
                            width: 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FormField<String>(
                                  key: nameKey,
                                  label: const Text('Text-Feld'),
                                  validator: const LengthValidator(min: 2),
                                  child: const TextField(
                                    placeholder: Text('Ihr Text ...'),
                                    initialValue: '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Text-Eingabefelder"),
                        CodeTextLine("SizedBox("),
                        CodeCommentLine("  # Für die Einschränkung in der Breite"),
                        CodeTextLine("  width: 500,"),
                        CodeTextLine("  child: Column("),
                        CodeTextLine("    crossAxisAlignment: CrossAxisAlignment.stretch,"),
                        CodeTextLine("    children: ["),
                        CodeTextLine("      FormField<String>("),
                        CodeTextLine("        key: nameKey,"),
                        CodeTextLine("        label: const Text('Text-Feld'),"),
                        CodeTextLine("        validator: const LengthValidator(min: 2),"),
                        CodeTextLine("        child: const TextField("),
                        CodeTextLine("          placeholder: Text('Ihr Text ...'),"),
                        CodeTextLine("          initialValue: '',"),
                        CodeTextLine("        ),"),
                        CodeTextLine("      ),"),
                        CodeCommentLine("      # Hier können weitere Komponenten eingefügt werden"),
                        CodeTextLine("    ],"),
                        CodeTextLine("  ),"),
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
