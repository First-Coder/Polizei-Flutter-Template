import 'package:police_flutter_template/screens/widgets/code_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../extensions/text_extensions.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int indexUnderlined = 0;
  int indexPills = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Gap(64),
        Text(
          'Tab-Elemente',
        ).h3.setColors(lightColor: Colors.gray[800], darkColor: Colors.white),
        Gap(50),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 752),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CodeCard(
                title: 'Unterstrichene Tabs',
                example: Column(
                  children: [
                    TabList(
                      index: indexUnderlined,
                      onChanged: (value) {
                        setState(() {
                          indexUnderlined = value;
                        });
                      },
                      children: const [
                        TabItem(
                          child: Text('Tab 1'),
                        ),
                        TabItem(
                          child: Text('Tab 2'),
                        ),
                        TabItem(
                          child: Text('Tab 3'),
                        ),
                      ],
                    ),const Gap(16),
                    IndexedStack(
                      index: indexUnderlined,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          color: Colors.red[100],
                          child: const Text('Tab 1').h4,
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.yellow[100],
                          child: const Text('Tab 2').h4,
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.blue[100],
                          child: const Text('Tab 3').h4,
                        ),
                      ],
                    ).sized(height: 100),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeTextLine(
                    "int indexUnderlined = 0;",
                  ),
                  CodeTextLine(""),
                  CodeCommentLine("# Beispiel für Unterstrichene Tabs"),
                  CodeTextLine("Column("),
                  CodeTextLine("  children: ["),
                  CodeTextLine("    TabList("),
                  CodeTextLine("      index: indexUnderlined,"),
                  CodeTextLine("      onChanged: (value) {"),
                  CodeTextLine("        setState(() {"),
                  CodeTextLine("          indexUnderlined = value;"),
                  CodeTextLine("        });"),
                  CodeTextLine("      },"),
                  CodeTextLine("      children: const ["),
                  CodeTextLine("        TabItem("),
                  CodeTextLine("          child: Text('Tab 1'),"),
                  CodeTextLine("        ),"),
                  CodeTextLine("        TabItem("),
                  CodeTextLine("          child: Text('Tab 2'),"),
                  CodeTextLine("        ),"),
                  CodeTextLine("        TabItem("),
                  CodeTextLine("          child: Text('Tab 3'),"),
                  CodeTextLine("        ),"),
                  CodeTextLine("      ],"),
                  CodeTextLine("    ),const Gap(16),"),
                  CodeTextLine("    IndexedStack("),
                  CodeTextLine("      index: indexUnderlined,"),
                  CodeTextLine("      children: ["),
                  CodeTextLine("        Container("),
                  CodeTextLine("          alignment: Alignment.center,"),
                  CodeTextLine("          color: Colors.red[100],"),
                  CodeTextLine("          child: const Text('Tab 1').h4,"),
                  CodeTextLine("        ),"),
                  CodeTextLine("        Container("),
                  CodeTextLine("          alignment: Alignment.center,"),
                  CodeTextLine("          color: Colors.yellow[100],"),
                  CodeTextLine("          child: const Text('Tab 2').h4,"),
                  CodeTextLine("        ),"),
                  CodeTextLine("        Container("),
                  CodeTextLine("          alignment: Alignment.center,"),
                  CodeTextLine("          color: Colors.blue[100],"),
                  CodeTextLine("          child: const Text('Tab 3').h4,"),
                  CodeTextLine("        ),"),
                  CodeTextLine("      ],"),
                  CodeTextLine("    ).sized(height: 100),"),
                  CodeTextLine("  ],"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),CodeCard(
                title: 'Pillen-Tabs',
                example: Column(
                  children: [
                    Tabs(
                      index: indexPills,
                      children: const [
                        TabItem(child: Text('Tab 1')),
                        TabItem(child: Text('Tab 2')),
                        TabItem(child: Text('Tab 3')),
                      ],
                      onChanged: (int value) {
                        setState(() {
                          indexPills = value;
                        });
                      },
                    ),const Gap(16),
                    IndexedStack(
                      index: indexPills,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          color: Colors.red[100],
                          child: const Text('Tab 1').h4,
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.yellow[100],
                          child: const Text('Tab 2').h4,
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.blue[100],
                          child: const Text('Tab 3').h4,
                        ),
                      ],
                    ).sized(height: 100),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeTextLine(
                    "int indexPills = 0;",
                  ),
                  CodeTextLine(""),
                  CodeCommentLine("# Beispiel für Pillen-Tabs"),
                  CodeTextLine("Column("),
                  CodeTextLine("  children: ["),
                  CodeTextLine("    Tabs("),
                  CodeTextLine("      index: indexPills,"),
                  CodeTextLine("      children: const ["),
                  CodeTextLine("        TabItem(child: Text('Tab 1')),"),
                  CodeTextLine("        TabItem(child: Text('Tab 2')),"),
                  CodeTextLine("        TabItem(child: Text('Tab 3')),"),
                  CodeTextLine("      ],"),
                  CodeTextLine("      onChanged: (int value) {"),
                  CodeTextLine("        setState(() {"),
                  CodeTextLine("          indexPills = value;"),
                  CodeTextLine("        });"),
                  CodeTextLine("      },"),
                  CodeTextLine("    ),const Gap(16),"),
                  CodeTextLine("    IndexedStack("),
                  CodeTextLine("      index: indexPills,"),
                  CodeTextLine("      children: ["),
                  CodeTextLine("        Container("),
                  CodeTextLine("          alignment: Alignment.center,"),
                  CodeTextLine("          color: Colors.red[100],"),
                  CodeTextLine("          child: const Text('Tab 1').h4,"),
                  CodeTextLine("        ),"),
                  CodeTextLine("        Container("),
                  CodeTextLine("          alignment: Alignment.center,"),
                  CodeTextLine("          color: Colors.yellow[100],"),
                  CodeTextLine("          child: const Text('Tab 2').h4,"),
                  CodeTextLine("        ),"),
                  CodeTextLine("        Container("),
                  CodeTextLine("          alignment: Alignment.center,"),
                  CodeTextLine("          color: Colors.blue[100],"),
                  CodeTextLine("          child: const Text('Tab 3').h4,"),
                  CodeTextLine("        ),"),
                  CodeTextLine("      ],"),
                  CodeTextLine("    ).sized(height: 100),"),
                  CodeTextLine("  ],"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
            ],
          ),
        ),
      ],
    );
  }
}
