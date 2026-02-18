import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/extensions/widget_extensions.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';
import '../../widgets/code_card.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final _firstnameKey = const TextFieldKey('firstname');
  final _lastnameKey = const TextFieldKey('lastname');

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
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
                ).gap(10),
              ),
            ),
            lines: [
              CodeTextLine("Card("),
              CodeTextLine("  child: Column("),
              CodeTextLine("    crossAxisAlignment: CrossAxisAlignment.start,"),
              CodeTextLine("    children: ["),
              CodeTextLine(
                "      IconContainer(icon: Icon(LucideIcons.info)),",
              ),
              CodeTextLine("      Basic("),
              CodeTextLine("        title: Text('Basis Card').base,"),
              CodeTextLine("        subtitle: Text("),
              CodeTextLine(
                "          'Eine einfache Card-Komponente mit Titel und Text.'",
              ),
              CodeTextLine("        ).small,"),
              CodeTextLine("        titleSpacing: 20,"),
              CodeTextLine("        content: LinkButton("),
              CodeTextLine("          density: ButtonDensity.compact,"),
              CodeTextLine("          onPressed: () {},"),
              CodeTextLine("          trailing: Icon(LucideIcons.arrowRight),"),
              CodeTextLine("          child: Text('Mehr erfahren'),"),
              CodeTextLine("        ),"),
              CodeTextLine("      ),"),
              CodeTextLine("    ],"),
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
                      title: Text('Basis Card mit Icon').base,
                      subtitle: Text(
                        'Eine einfache Card-Komponente mit Titel und Text sowie einem Icon.',
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
                ).gap(10),
              ),
            ),
            lines: [
              CodeTextLine("Card("),
              CodeTextLine("  child: Column("),
              CodeTextLine("    crossAxisAlignment: CrossAxisAlignment.start,"),
              CodeTextLine("    children: ["),
              CodeTextLine(
                "      IconContainer(icon: Icon(LucideIcons.info)),",
              ),
              CodeTextLine("      Basic("),
              CodeTextLine("        title: Text('Basis Card').base,"),
              CodeTextLine("        subtitle: Text("),
              CodeTextLine(
                "          'Eine einfache Card-Komponente mit Titel und Text.'",
              ),
              CodeTextLine("        ).small,"),
              CodeTextLine("        titleSpacing: 20,"),
              CodeTextLine("        content: LinkButton("),
              CodeTextLine("          density: ButtonDensity.compact,"),
              CodeTextLine("          onPressed: () {},"),
              CodeTextLine("          trailing: Icon(LucideIcons.arrowRight),"),
              CodeTextLine("          child: Text('Mehr erfahren'),"),
              CodeTextLine("        ),"),
              CodeTextLine("      ),"),
              CodeTextLine("    ],"),
              CodeTextLine("  ),"),
              CodeTextLine(");"),
            ],
          ),
          CodeCard(
            title: "Basis Card mit Icon und Hover effekt",
            example: SizedBox(
              width: double.infinity,
              child:
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconContainer(icon: Icon(LucideIcons.info)),
                        Basic(
                          title: Text('Basis Card mit Icon').base,
                          subtitle: Text(
                            'Eine einfache Card-Komponente mit Titel und Text sowie einem Icon. Hover me um den Effekt zu sehen.',
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
                    ).gap(10),
                  ).withHoverEffect(
                    borderWidth: 2,
                    borderColor: isDark ? Colors.gray[700] : Colors.gray[200],
                    hoverBorderColor: isDark
                        ? Colors.red[900]
                        : Colors.red[400],
                  ),
            ),
            lines: [
              CodeTextLine("Card("),
              CodeTextLine("  child: Column("),
              CodeTextLine("    crossAxisAlignment: CrossAxisAlignment.start,"),
              CodeTextLine("    children: ["),
              CodeTextLine(
                "      IconContainer(icon: Icon(LucideIcons.info)),",
              ),
              CodeTextLine("      Basic("),
              CodeTextLine("        title: Text('Basis Card').base,"),
              CodeTextLine("        subtitle: Text("),
              CodeTextLine(
                "          'Eine einfache Card-Komponente mit Titel und Text.'",
              ),
              CodeTextLine("        ).small,"),
              CodeTextLine("        titleSpacing: 20,"),
              CodeTextLine("        content: LinkButton("),
              CodeTextLine("          density: ButtonDensity.compact,"),
              CodeTextLine("          onPressed: () {},"),
              CodeTextLine("          trailing: Icon(LucideIcons.arrowRight),"),
              CodeTextLine("          child: Text('Mehr erfahren'),"),
              CodeTextLine("        ),"),
              CodeTextLine("      ),"),
              CodeTextLine("    ],"),
              CodeTextLine("  ),"),
              CodeTextLine(").withHoverEffect("),
              CodeTextLine("    borderWidth: 2,"),
              CodeTextLine(
                "    borderColor: isDark ? Colors.gray[700] : Colors.gray[200],",
              ),
              CodeTextLine(
                "    hoverBorderColor: isDark ? Colors.red[900] : Colors.red[400],",
              ),
              CodeTextLine(");"),
            ],
          ),
          CodeCard(
            title: "Basis Card mit Action",
            example: SizedBox(
              width: double.infinity,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Basic(
                      title: Text('Basis Card mit Action').base,
                      trailing: IconButton.secondary(
                        onPressed: () {},
                        icon: Icon(LucideIcons.saveAll),
                      ),
                      subtitle: Text(
                        'Eine Card-Komponente in der hier im Anschluss ein Formular folgen kann. Speichern könnte man dan direkt darunter über den Speicher Button oder oben Rechts in der Ecke.',
                      ).small,
                      titleSpacing: 20,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormField<String>(
                            key: _firstnameKey,
                            label: Text('Vorname'),
                            child: SizedBox(
                              width: 400,
                              child: TextField(initialValue: 'Jane'),
                            ),
                          ),
                          FormField<String>(
                            key: _lastnameKey,
                            label: Text('Nachname'),
                            child: SizedBox(
                              width: 400,
                              child: TextField(initialValue: 'Doe'),
                            ),
                          ),
                          PrimaryButton(
                            onPressed: () {},
                            trailing: Icon(LucideIcons.save),
                            child: Text('Speichern'),
                          ),
                        ],
                      ).gap(15),
                    ),
                  ],
                ).gap(10),
              ),
            ),
            lines: [
              CodeTextLine("Card("),
              CodeTextLine("  child: Column("),
              CodeTextLine(
                "    crossAxisAlignment: CrossAxisAlignment.stretch,",
              ),
              CodeTextLine("    children: ["),
              CodeTextLine("      Basic("),
              CodeTextLine(
                "        title: Text('Basis Card mit Action').base,",
              ),
              CodeTextLine("        trailing: IconButton.secondary("),
              CodeTextLine("          onPressed: () {},"),
              CodeTextLine("          icon: Icon(LucideIcons.saveAll),"),
              CodeTextLine("        ),"),
              CodeTextLine("        subtitle: Text("),
              CodeTextLine(
                "          'Eine Card-Komponente in der hier im Anschluss ein Formular folgen kann. Speichern könnte man dan direkt darunter über den Speicher Button oder oben Rechts in der Ecke.'",
              ),
              CodeTextLine("        ).small,"),
              CodeTextLine("        titleSpacing: 20,"),
              CodeTextLine("        content: Column("),
              CodeTextLine(
                "          crossAxisAlignment: CrossAxisAlignment.start,",
              ),
              CodeTextLine("          children: ["),
              CodeTextLine("            FormField<String>("),
              CodeTextLine("              key: _firstnameKey,"),
              CodeTextLine("              label: Text('Vorname'),"),
              CodeTextLine("              child: SizedBox("),
              CodeTextLine("                width: 400,"),
              CodeTextLine(
                "                child: TextField(initialValue: 'Jane'),",
              ),
              CodeTextLine("              ),"),
              CodeTextLine("            ),"),
              CodeTextLine("            FormField<String>("),
              CodeTextLine("              key: _lastnameKey,"),
              CodeTextLine("              label: Text('Nachname'),"),
              CodeTextLine("              child: SizedBox("),
              CodeTextLine("                width: 400,"),
              CodeTextLine(
                "                child: TextField(initialValue: 'Doe'),",
              ),
              CodeTextLine("              ),"),
              CodeTextLine("            ),"),
              CodeTextLine("            PrimaryButton("),
              CodeTextLine("              onPressed: () {},"),
              CodeTextLine("              trailing: Icon(LucideIcons.save),"),
              CodeTextLine("              child: Text('Speichern'),"),
              CodeTextLine("            ),"),
              CodeTextLine("          ],"),
              CodeTextLine("        ).gap(15),"),
              CodeTextLine("      ),"),
              CodeTextLine("    ],"),
              CodeTextLine("  ),"),
              CodeTextLine(");"),
            ],
          ),
        ],
      ).gap(15).withPadding(vertical: 30),
    ).withPadding(horizontal: 20);
  }
}
