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
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 752),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(64),
              Text('Buttons', textAlign: TextAlign.center).h3.setColors(
                lightColor: Colors.gray[800],
                darkColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Buttons ermöglichen es dem Benutzer, mit einem einzigen Klick Aktionen auszuführen und Entscheidungen zu treffen.',
                  textAlign: TextAlign.center,
                ).h4.setColors(
                  lightColor: Colors.blue[800],
                  darkColor: Colors.blue[400],
                ),
              ),
              Gap(64),
              CodeCard(
                title: 'Primäre Buttons',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    PrimaryButton(
                      onPressed: () {},
                      child: const Text('Standard'),
                    ),
                    PrimaryButton(
                      leading: const Icon(LucideIcons.download),
                      onPressed: () {},
                      child: const Text('Mit Icon vorne'),
                    ),
                    PrimaryButton(
                      trailing: const Icon(LucideIcons.arrowRight),
                      onPressed: () {},
                      child: const Text('Mit Icon hinten'),
                    ),
                    PrimaryButton(child: const Text('Deaktiviert')),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Beispiel für Primäre Buttons"),
                  CodeTextLine("PrimaryButton("),
                  CodeCommentLine("  # Mit Icon vorne"),
                  CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                  CodeCommentLine("  # Mit Icon hinten"),
                  CodeTextLine(
                    "  trailing: const Icon(LucideIcons.arrowRight),",
                  ),
                  CodeCommentLine(
                    "  # Für aktiven Button (bei deaktiviertem Button weglassen)",
                  ),
                  CodeTextLine("  onPressed: () {},"),
                  CodeCommentLine("  # Text des Buttons"),
                  CodeTextLine("  child: const Text('Primärer Button'),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Sekundäre Buttons',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SecondaryButton(
                      onPressed: () {},
                      child: const Text('Standard'),
                    ),
                    SecondaryButton(
                      leading: const Icon(LucideIcons.download),
                      onPressed: () {},
                      child: const Text('Mit Icon vorne'),
                    ),
                    SecondaryButton(
                      trailing: const Icon(LucideIcons.arrowRight),
                      onPressed: () {},
                      child: const Text('Mit Icon hinten'),
                    ),
                    SecondaryButton(child: const Text('Deaktiviert')),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Beispiel für Sekundäre Buttons"),
                  CodeTextLine("SecondaryButton("),
                  CodeCommentLine("  # Mit Icon vorne"),
                  CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                  CodeCommentLine("  # Mit Icon hinten"),
                  CodeTextLine(
                    "  trailing: const Icon(LucideIcons.arrowRight),",
                  ),
                  CodeCommentLine(
                    "  # Für aktiven Button (bei deaktiviertem Button weglassen)",
                  ),
                  CodeTextLine("  onPressed: () {},"),
                  CodeCommentLine("  # Text des Buttons"),
                  CodeTextLine("  child: const Text('Sekundärer Button'),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Umrandete Buttons',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    OutlineButton(
                      onPressed: () {},
                      child: const Text('Standard'),
                    ),
                    OutlineButton(
                      leading: const Icon(LucideIcons.download),
                      onPressed: () {},
                      child: const Text('Mit Icon'),
                    ),
                    OutlineButton(child: const Text('Deaktiviert')),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Beispiel für Umrandete Buttons"),
                  CodeTextLine("OutlineButton("),
                  CodeCommentLine("  # Mit Icon vorne"),
                  CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                  CodeCommentLine("  # Mit Icon hinten"),
                  CodeTextLine(
                    "  trailing: const Icon(LucideIcons.arrowRight),",
                  ),
                  CodeCommentLine(
                    "  # Für aktiven Button (bei deaktiviertem Button weglassen)",
                  ),
                  CodeTextLine("  onPressed: () {},"),
                  CodeCommentLine("  # Text des Buttons"),
                  CodeTextLine("  child: const Text('Umrandeter Button'),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Ghost Buttons',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    GhostButton(
                      onPressed: () {},
                      child: const Text('Standard'),
                    ),
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
                  CodeTextLine(
                    "  trailing: const Icon(LucideIcons.arrowRight),",
                  ),
                  CodeCommentLine(
                    "  # Für aktiven Button (bei deaktiviertem Button weglassen)",
                  ),
                  CodeTextLine("  onPressed: () {},"),
                  CodeCommentLine("  # Text des Buttons"),
                  CodeTextLine("  child: const Text('Ghost Button'),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Destruktive Buttons',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    DestructiveButton(
                      onPressed: () {},
                      child: const Text('Standard'),
                    ),
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
                  CodeTextLine(
                    "  trailing: const Icon(LucideIcons.arrowRight),",
                  ),
                  CodeCommentLine(
                    "  # Für aktiven Button (bei deaktiviertem Button weglassen)",
                  ),
                  CodeTextLine("  onPressed: () {},"),
                  CodeCommentLine("  # Text des Buttons"),
                  CodeTextLine("  child: const Text('Destruktiver Button'),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Link-Buttons',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    LinkButton(onPressed: () {}, child: const Text('Standard')),
                    LinkButton(
                      leading: const Icon(LucideIcons.download),
                      onPressed: () {},
                      child: const Text('Mit Icon'),
                    ),
                    LinkButton(child: const Text('Deaktiviert')),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Beispiel für Link-Buttons"),
                  CodeTextLine("LinkButton("),
                  CodeCommentLine("  # Mit Icon vorne"),
                  CodeTextLine("  leading: const Icon(LucideIcons.download),"),
                  CodeCommentLine("  # Mit Icon hinten"),
                  CodeTextLine(
                    "  trailing: const Icon(LucideIcons.arrowRight),",
                  ),
                  CodeCommentLine(
                    "  # Für aktiven Button (bei deaktiviertem Button weglassen)",
                  ),
                  CodeTextLine("  onPressed: () {},"),
                  CodeCommentLine("  # Text des Buttons"),
                  CodeTextLine("  child: const Text('Link-Button'),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Icon-Buttons',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    IconButton.primary(
                      onPressed: () {},
                      density: ButtonDensity.icon,
                      icon: const Icon(Icons.add),
                    ),
                    IconButton.secondary(
                      onPressed: () {},
                      density: ButtonDensity.icon,
                      icon: const Icon(Icons.add),
                    ),
                    IconButton.outline(
                      onPressed: () {},
                      density: ButtonDensity.icon,
                      icon: const Icon(Icons.add),
                    ),
                    IconButton.ghost(
                      onPressed: () {},
                      density: ButtonDensity.icon,
                      icon: const Icon(Icons.add),
                    ),
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
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Button-Größen',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    PrimaryButton(
                      onPressed: () {},
                      size: ButtonSize.xSmall,
                      child: const Text('Extra Klein'),
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      size: ButtonSize.small,
                      child: const Text('Klein'),
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      size: ButtonSize.normal,
                      child: const Text('Normal'),
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      size: ButtonSize.large,
                      child: const Text('Groß'),
                    ),
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
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Button-Dichten',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    PrimaryButton(
                      onPressed: () {},
                      density: ButtonDensity.compact,
                      child: const Text('Kompakt'),
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      density: ButtonDensity.dense,
                      child: const Text('Dicht'),
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      density: ButtonDensity.normal,
                      child: const Text('Normal'),
                    ),
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
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Button-Formen',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    PrimaryButton(
                      onPressed: () {},
                      shape: ButtonShape.circle,
                      child: const Icon(Icons.add),
                    ),
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
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Button mit Status',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    PrimaryButton(
                      leading: const StatedWidget.map(
                        states: {
                          'disabled': Icon(Icons.close),
                          {WidgetState.hovered, WidgetState.focused}: Icon(
                            Icons.add_a_photo_rounded,
                          ),
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
                  CodeCommentLine(
                    "# Beispiel für Buttons mit sich änderndem Status",
                  ),
                  CodeTextLine("PrimaryButton("),
                  CodeTextLine("  leading: const StatedWidget.map("),
                  CodeTextLine("    states: {"),
                  CodeTextLine("      'disabled': Icon(Icons.close),"),
                  CodeTextLine(
                    "      {WidgetState.hovered, WidgetState.focused}:",
                  ),
                  CodeTextLine("      Icon(Icons.add_a_photo_rounded),"),
                  CodeTextLine(
                    "      WidgetState.hovered: Icon(Icons.add_a_photo),",
                  ),
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
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Button-Karte',
                example: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    CardButton(
                      onPressed: () {},
                      child: const Basic(
                        title: Text('Projekt #1'),
                        subtitle: Text('Projektbeschreibung'),
                        content: Text(
                          'Dieses Projekt beschäftigt sich mit dem Thema X.',
                        ),
                      ),
                    ),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Beispiel für Button-Karte"),
                  CodeTextLine("CardButton("),
                  CodeTextLine("  onPressed: () {},"),
                  CodeTextLine("  child: const Basic("),
                  CodeTextLine("    title: Text('Projekt #1'),"),
                  CodeTextLine("    subtitle: Text('Projektbeschreibung'),"),
                  CodeTextLine(
                    "    content: Text('Dieses Projekt beschäftigt sich mit dem Thema X.'),",
                  ),
                  CodeTextLine("  ),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Personalisierte Buttons',
                example: Row(
                  children: [
                    Button(
                      style: const ButtonStyle.primary()
                          .withBackgroundColor(
                            color: Colors.yellow,
                            hoverColor: Colors.purple,
                          )
                          .withForegroundColor(
                            color: Colors.black,
                            hoverColor: Colors.white,
                          )
                          .withBorderRadius(
                            hoverBorderRadius: BorderRadius.circular(16),
                          ),
                      onPressed: () {},
                      leading: const Icon(LucideIcons.sun),
                      trailing: const Icon(LucideIcons.moon),
                      child: const Text('Mein Button'),
                    ),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Beispiel für Personalisierte Buttons"),
                  CodeTextLine("Button("),
                  CodeTextLine("  style: const ButtonStyle.primary()"),
                  CodeTextLine(
                    "    .withBackgroundColor(color: Colors.yellow, hoverColor: Colors.purple)",
                  ),
                  CodeTextLine(
                    "    .withForegroundColor(color: Colors.black, hoverColor: Colors.white)",
                  ),
                  CodeTextLine(
                    "    .withBorderRadius(hoverBorderRadius: BorderRadius.circular(16)),",
                  ),
                  CodeTextLine("  onPressed: () {},"),
                  CodeTextLine("  leading: const Icon(LucideIcons.sun),"),
                  CodeTextLine("  trailing: const Icon(LucideIcons.moon),"),
                  CodeTextLine(
                    "  child: const Text('Personalisierter Button'),",
                  ),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
            ],
          ),
        ),
        Gap(64),
      ],
    );
  }
}
