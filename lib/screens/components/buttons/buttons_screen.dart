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
        Text('Buttons').h3.setColors(
          lightColor: Colors.gray[800],
          darkColor: Colors.white,
        ),
        Text(
          'Buttons ermöglichen es dem Benutzer, mit einem einzigen Klick \n'
          'Aktionen auszuführen und Entscheidungen zu treffen.',
          textAlign: TextAlign.center,
        ).h4.setColors(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 900),
                    child: CodeCard(
                      title: 'Sekundäre Buttons',
                      example: Row(
                        children: [
                          SecondaryButton(
                            onPressed: () {},
                            child: const Text('Standard'),
                          ),
                          Gap(10),
                          SecondaryButton(
                            leading: const Icon(LucideIcons.download),
                            onPressed: () {},
                            child: const Text('Mit Icon vorne'),
                          ),
                          Gap(10),
                          SecondaryButton(
                            trailing: const Icon(LucideIcons.arrowRight),
                            onPressed: () {},
                            child: const Text('Mit Icon hinten'),
                          ),
                          Gap(10),
                          SecondaryButton(
                            child: const Text('Deaktiviert'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Sekundäre Buttons"),
                        CodeTextLine("SecondaryButton("),
                        CodeCommentLine("  # Mit Icon vorne"),
                        CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                        CodeCommentLine("  # Mit Icon hinten"),
                        CodeTextLine("  trailing: const Icon(LucideIcons.arrowRight),"),
                        CodeCommentLine("  # Für aktiven Button (bei deaktiviertem Button weglassen)"),
                        CodeTextLine("  onPressed: () {},"),
                        CodeCommentLine("  # Text des Buttons"),
                        CodeTextLine("  child: const Text('Sekundärer Button'),"),
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
                      title: 'Umrandete Buttons',
                      example: Row(
                        children: [
                          OutlineButton(
                            onPressed: () {},
                            child: const Text('Standard'),
                          ),
                          Gap(10),
                          OutlineButton(
                            leading: const Icon(LucideIcons.download),
                            onPressed: () {},
                            child: const Text('Mit Icon'),
                          ),
                          Gap(10),
                          OutlineButton(
                            child: const Text('Deaktiviert'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Umrandete Buttons"),
                        CodeTextLine("OutlineButton("),
                        CodeCommentLine("  # Mit Icon vorne"),
                        CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                        CodeCommentLine("  # Mit Icon hinten"),
                        CodeTextLine("  trailing: const Icon(LucideIcons.arrowRight),"),
                        CodeCommentLine("  # Für aktiven Button (bei deaktiviertem Button weglassen)"),
                        CodeTextLine("  onPressed: () {},"),
                        CodeCommentLine("  # Text des Buttons"),
                        CodeTextLine("  child: const Text('Umrandeter Button'),"),
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
                      title: 'Ghost Buttons',
                      example: Row(
                        children: [
                          GhostButton(
                            onPressed: () {},
                            child: const Text('Standard'),
                          ),
                          Gap(10),
                          GhostButton(
                            leading: const Icon(LucideIcons.download),
                            onPressed: () {},
                            child: const Text('Mit Icon'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Ghost Buttons"),
                        CodeTextLine("GhostButton("),
                        CodeCommentLine("  # Mit Icon vorne"),
                        CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                        CodeCommentLine("  # Mit Icon hinten"),
                        CodeTextLine("  trailing: const Icon(LucideIcons.arrowRight),"),
                        CodeCommentLine("  # Für aktiven Button (bei deaktiviertem Button weglassen)"),
                        CodeTextLine("  onPressed: () {},"),
                        CodeCommentLine("  # Text des Buttons"),
                        CodeTextLine("  child: const Text('Ghost Button'),"),
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
                      title: 'Destruktive Buttons',
                      example: Row(
                        children: [
                          DestructiveButton(
                            onPressed: () {},
                            child: const Text('Standard'),
                          ),
                          Gap(10),
                          DestructiveButton(
                            leading: const Icon(LucideIcons.download),
                            onPressed: () {},
                            child: const Text('Mit Icon'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Destruktive Buttons"),
                        CodeTextLine("DestructiveButton("),
                        CodeCommentLine("  # Mit Icon vorne"),
                        CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                        CodeCommentLine("  # Mit Icon hinten"),
                        CodeTextLine("  trailing: const Icon(LucideIcons.arrowRight),"),
                        CodeCommentLine("  # Für aktiven Button (bei deaktiviertem Button weglassen)"),
                        CodeTextLine("  onPressed: () {},"),
                        CodeCommentLine("  # Text des Buttons"),
                        CodeTextLine("  child: const Text('Destruktiver Button'),"),
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
                      title: 'Link-Buttons',
                      example: Row(
                        children: [
                          LinkButton(
                            onPressed: () {},
                            child: const Text('Standard'),
                          ),
                          Gap(10),
                          LinkButton(
                            leading: const Icon(LucideIcons.download),
                            onPressed: () {},
                            child: const Text('Mit Icon'),
                          ),
                          Gap(10),
                          LinkButton(
                            child: const Text('Deaktiviert'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Link-Buttons"),
                        CodeTextLine("LinkButton("),
                        CodeCommentLine("  # Mit Icon vorne"),
                        CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                        CodeCommentLine("  # Mit Icon hinten"),
                        CodeTextLine("  trailing: const Icon(LucideIcons.arrowRight),"),
                        CodeCommentLine("  # Für aktiven Button (bei deaktiviertem Button weglassen)"),
                        CodeTextLine("  onPressed: () {},"),
                        CodeCommentLine("  # Text des Buttons"),
                        CodeTextLine("  child: const Text('Link-Button'),"),
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
                      title: 'Icon-Buttons',
                      example: Row(
                        children: [
                          IconButton.primary(
                            onPressed: () {},
                            density: ButtonDensity.icon,
                            icon: const Icon(Icons.add),
                          ),
                          Gap(10),
                          IconButton.secondary(
                            onPressed: () {},
                            density: ButtonDensity.icon,
                            icon: const Icon(Icons.add),
                          ),
                          Gap(10),
                          IconButton.outline(
                            onPressed: () {},
                            density: ButtonDensity.icon,
                            icon: const Icon(Icons.add),
                          ),
                          Gap(10),
                          IconButton.ghost(
                            onPressed: () {},
                            density: ButtonDensity.icon,
                            icon: const Icon(Icons.add),
                          ),
                          Gap(10),
                          IconButton.destructive(
                            onPressed: () {},
                            density: ButtonDensity.icon,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Primäre Icon-Buttons"),
                        CodeTextLine("IconButton.primary("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.icon,"),
                        CodeTextLine("  icon: const Icon(Icons.add),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für Sekundäre Icon-Buttons"),
                        CodeTextLine("IconButton.secondary("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.icon,"),
                        CodeTextLine("  icon: const Icon(Icons.add),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für Umrandete Icon-Buttons"),
                        CodeTextLine("IconButton.outline("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.icon,"),
                        CodeTextLine("  icon: const Icon(Icons.add),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für Ghost Icon-Buttons"),
                        CodeTextLine("IconButton.ghost("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.icon,"),
                        CodeTextLine("  icon: const Icon(Icons.add),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für Destruktive Icon-Buttons"),
                        CodeTextLine("IconButton.destructive("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.icon,"),
                        CodeTextLine("  icon: const Icon(Icons.add),"),
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
                      title: 'Button-Größen',
                      example: Row(
                        children: [
                          PrimaryButton(
                            onPressed: () {},
                            size: ButtonSize.xSmall,
                            child: const Text('Extra Klein'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            onPressed: () {},
                            size: ButtonSize.small,
                            child: const Text('Klein'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            onPressed: () {},
                            size: ButtonSize.normal,
                            child: const Text('Normal'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            onPressed: () {},
                            size: ButtonSize.large,
                            child: const Text('Groß'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            onPressed: () {},
                            size: ButtonSize.xLarge,
                            child: const Text('Extra Groß'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für extra-kleine Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  size: ButtonSize.xSmall,"),
                        CodeTextLine("  child: const Text('Extra Klein'),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für kleine Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  size: ButtonSize.small,"),
                        CodeTextLine("  child: const Text('Klein'),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für normale Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  size: ButtonSize.normal,"),
                        CodeTextLine("  child: const Text('Normal'),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für große Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  size: ButtonSize.large,"),
                        CodeTextLine("  child: const Text('Groß'),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für extra-große Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  size: ButtonSize.xLarge,"),
                        CodeTextLine("  child: const Text('Extra Groß'),"),
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
                      title: 'Button-Dichten',
                      example: Row(
                        children: [
                          PrimaryButton(
                            onPressed: () {},
                            density: ButtonDensity.compact,
                            child: const Text('Kompakt'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            onPressed: () {},
                            density: ButtonDensity.dense,
                            child: const Text('Dicht'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            onPressed: () {},
                            density: ButtonDensity.normal,
                            child: const Text('Normal'),
                          ),
                          Gap(10),
                          PrimaryButton(
                            onPressed: () {},
                            density: ButtonDensity.comfortable,
                            child: const Text('Weit'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für kompakte Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.compact,"),
                        CodeTextLine("  child: const Text('Kompakt'),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für dichte Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.dense,"),
                        CodeTextLine("  child: const Text('Dicht'),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für normale Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.normal,"),
                        CodeTextLine("  child: const Text('Normal'),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für weite Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  density: ButtonDensity.comfortable,"),
                        CodeTextLine("  child: const Text('Weit'),"),
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
                      title: 'Button-Formen',
                      example: Row(
                        children: [
                          PrimaryButton(
                            onPressed: () {},
                            shape: ButtonShape.circle,
                            child: const Icon(Icons.add),
                          ),
                          Gap(10),
                          PrimaryButton(
                            onPressed: () {},
                            shape: ButtonShape.rectangle,
                            child: const Text('Rechteckig'),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Runde Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  shape: ButtonShape.circle,"),
                        CodeTextLine("  child: const Icon(Icons.add),"),
                        CodeTextLine("),"),
                        CodeCommentLine("# Beispiel für rechteckige Buttons"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  shape: ButtonShape.rectangle,"),
                        CodeTextLine("  child: const Text('Rechteckig'),"),
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
                      title: 'Button mit Status',
                      example: Row(
                        children: [
                          PrimaryButton(
                            leading: const StatedWidget.map(
                              states: {
                                'disabled': Icon(Icons.close),
                                {WidgetState.hovered, WidgetState.focused}:
                                Icon(Icons.add_a_photo_rounded),
                                WidgetState.hovered: Icon(Icons.add_a_photo),
                              },
                              child: Icon(Icons.add_a_photo_outlined),
                            ),
                            onPressed: () {},
                            child: const StatedWidget(
                              focused: Text('Focused'),
                              hovered: Text('Hovered'),
                              pressed: Text('Pressed'),
                              child: Text('Normal'),
                            ),
                          ),
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Buttons mit sich änderndem Status"),
                        CodeTextLine("PrimaryButton("),
                        CodeTextLine("  leading: const StatedWidget.map("),
                        CodeTextLine("    states: {"),
                        CodeTextLine("      'disabled': Icon(Icons.close),"),
                        CodeTextLine("      {WidgetState.hovered, WidgetState.focused}:"),
                        CodeTextLine("      Icon(Icons.add_a_photo_rounded),"),
                        CodeTextLine("      WidgetState.hovered: Icon(Icons.add_a_photo),"),
                        CodeTextLine("    },"),
                        CodeTextLine("    child: Icon(Icons.add_a_photo_outlined),"),
                        CodeTextLine("  ),"),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  child: const StatedWidget("),
                        CodeTextLine("    focused: Text('Focused'),"),
                        CodeTextLine("    hovered: Text('Hovered'),"),
                        CodeTextLine("    pressed: Text('Pressed'),"),
                        CodeTextLine("    child: Text('Normal'),"),
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
                      title: 'Button-Karte',
                      example: Row(
                        children: [
                          CardButton(
                            onPressed: () {},
                            child: const Basic(
                              title: Text('Projekt #1'),
                              subtitle: Text('Projektbeschreibung'),
                              content:
                              Text('Dieses Projekt beschäftigt sich mit dem Thema X.'),
                            ),
                          )
                        ],
                      ),
                      lines: [
                        CodeCommentLine("# Beispiel für Button-Karte"),
                        CodeTextLine("CardButton("),
                        CodeTextLine("  onPressed: () {},"),
                        CodeTextLine("  child: const Basic("),
                        CodeTextLine("    title: Text('Projekt #1'),"),
                        CodeTextLine("    subtitle: Text('Projektbeschreibung'),"),
                        CodeTextLine("    content: Text('Dieses Projekt beschäftigt sich mit dem Thema X.'),"),
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
