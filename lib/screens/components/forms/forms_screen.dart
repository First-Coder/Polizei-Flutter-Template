import 'package:police_flutter_template/extensions/button_extensions.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../extensions/text_extensions.dart';
import '../../widgets/code_card.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  CheckboxState checkState = CheckboxState.unchecked;
  CheckboxState triCheckState = CheckboxState.unchecked;
  int? selectedValue;
  int cardValue = 1;
  bool toggleValue = false;
  SliderValue sliderValue = const SliderValue.single(0.5);
  SliderValue rangeSliderValue = const SliderValue.ranged(0.5, 0.75);

  @override
  Widget build(BuildContext context) {
    final nameKey = const TextFieldKey('name'); // TextField → String
    final mailKey = const TextFieldKey('mail'); // TextField → String
    final birthdayKey = const DatePickerKey(
      'birthday',
    ); // DatePicker → DateTime

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Gap(64),
        Text(
          'Formular-Elemente',
        ).h3.setColors(lightColor: Colors.gray[800], darkColor: Colors.white),
        Gap(50),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 752),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CodeCard(
                title: 'Text-Eingaben',
                example: Column(
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
                lines: [
                  CodeCommentLine("# Am Anfang der Funktion angeben"),
                  CodeTextLine(
                    "final textKey = const TextFieldKey('text'); // TextField → String",
                  ),
                  CodeTextLine(""),
                  CodeCommentLine("# Beispiel für Text-Eingabefelder"),
                  CodeTextLine("FormField<String>("),
                  CodeTextLine("  key: textKey,"),
                  CodeTextLine("  label: const Text('Text-Feld'),"),
                  CodeCommentLine(
                    "  # Validierung: Mindestlänge der Eingabe sind 2 Zeichen",
                  ),
                  CodeTextLine("  validator: const LengthValidator(min: 2),"),
                  CodeTextLine("  child: const TextField("),
                  CodeTextLine("    placeholder: Text('Ihr Text ...'),"),
                  CodeTextLine("    initialValue: '',"),
                  CodeTextLine("  ),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Email-Eingaben',
                example: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormField<String>(
                      key: mailKey,
                      label: const Text('Email'),
                      validator: const EmailValidator(
                        message:
                            'Bitte geben Sie eine gültige Email-Adresse ein',
                      ),
                      child: const TextField(
                        placeholder: Text('ihre@email.de'),
                      ),
                    ),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Funktion angeben"),
                  CodeTextLine(
                    "final mailKey = const TextFieldKey('mail'); // TextField → String",
                  ),
                  CodeTextLine(""),
                  CodeCommentLine("# Beispiel für Email-Eingabefelder"),
                  CodeTextLine("FormField<String>("),
                  CodeTextLine("  key: mailKey,"),
                  CodeTextLine("  label: const Text('Email'),"),
                  CodeCommentLine("  # Validierung: Gültige Email-Adresse"),
                  CodeTextLine("  validator: const EmailValidator("),
                  CodeTextLine(
                    "    message: 'Bitte geben Sie eine gültige Email-Adresse ein',",
                  ),
                  CodeTextLine("  ),"),
                  CodeTextLine("  child: const TextField("),
                  CodeTextLine("    placeholder: Text('ihre@email.de'),"),
                  CodeTextLine("  ),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Datum-Eingaben',
                example: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormField<DateTime>(
                      key: birthdayKey,
                      label: const Text('Datum'),
                      validator: const NonNullValidator(
                        message: 'Bitte geben Sie ein Datum ein',
                      ),
                      child: const ControlledDatePicker(),
                    ),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Funktion angeben"),
                  CodeTextLine(
                    "final dateKey = const DatePickerKey('date'); // DatePicker → DateTime",
                  ),
                  CodeTextLine(""),
                  CodeCommentLine("# Beispiel für Datum-Eingabefelder"),
                  CodeTextLine("FormField<DateTime>("),
                  CodeTextLine("  key: dateKey,"),
                  CodeTextLine("  label: const Text('Datum'),"),
                  CodeCommentLine(
                    "  # Validierung: Eingabe darf nicht leer sein",
                  ),
                  CodeTextLine(
                    "  validator: const NonNullValidator(message: 'Bitte geben Sie ein Datum ein'),",
                  ),
                  CodeTextLine("  child: const ControlledDatePicker(),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Text-Area',
                example: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TextArea(
                      initialValue: 'Hallo, Welt!',
                      // Enable both horizontal and vertical growth based on content.
                      expandableWidth: true,
                      expandableHeight: true,
                      // Larger starting dimensions to make the behavior obvious.
                      initialWidth: 500,
                      initialHeight: 100,
                    ),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Beispiel für Textarea-Felder"),
                  CodeTextLine("const TextArea("),
                  CodeTextLine("  initialValue: 'Hallo, Welt!',"),
                  CodeCommentLine(
                    "  # Angabe ob Höhe(Height) und/oder Breite(Width) anpassbar sein sollen",
                  ),
                  CodeTextLine("  expandableWidth: true,"),
                  CodeTextLine("  expandableHeight: true,"),
                  CodeCommentLine("  # Die initiale Höhe und Breite"),
                  CodeTextLine("  initialWidth: 500,"),
                  CodeTextLine("  initialHeight: 100,"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Dropdown-Menu',
                example: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlineButton(
                      child: const Text('Aufklappen'),
                      onPressed: () {},
                    ).withPopover(
                      builder: (context) {
                        return const DropdownMenu(
                          children: [
                            MenuLabel(child: Text('Mein Menü')),
                            MenuDivider(),
                            MenuButton(child: Text('Option 1')),
                            MenuButton(
                              subMenu: [
                                MenuButton(child: Text('Untermenü Option 2.1')),
                              ],
                              child: Text('Option 2'),
                            ),
                            MenuDivider(),
                            MenuButton(child: Text('Option 3')),
                          ],
                        );
                      },
                      anchorPlacement: Alignment.bottomCenter,
                      placement: Alignment.topCenter,
                      hoverCloseDelay: const Duration(milliseconds: 500),
                    ),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Beispiel für Dropdown-Menus"),
                  CodeTextLine("OutlineButton("),
                  CodeTextLine("  child: const Text('Aufklappen'),"),
                  CodeTextLine("  onPressed: () {},"),
                  CodeTextLine(").withPopover("),
                  CodeTextLine("  builder: (context) {"),
                  CodeTextLine("    return const DropdownMenu("),
                  CodeTextLine("      children: ["),
                  CodeTextLine("        MenuLabel(child: Text('Mein Menü')),"),
                  CodeTextLine("        MenuDivider(),"),
                  CodeTextLine("        MenuButton(child: Text('Option 1')),"),
                  CodeTextLine("        MenuButton("),
                  CodeTextLine("          subMenu: ["),
                  CodeTextLine(
                    "            MenuButton(child: Text('Untermenü Option 2.1')),",
                  ),
                  CodeTextLine("          ],"),
                  CodeTextLine("          child: Text('Option 2'),"),
                  CodeTextLine("        ),"),
                  CodeTextLine("        MenuDivider(),"),
                  CodeTextLine("        MenuButton(child: Text('Option 3')),"),
                  CodeTextLine("      ],"),
                  CodeTextLine("    );"),
                  CodeTextLine("  },"),
                  CodeCommentLine("  # Wo am Button das Menü ankert"),
                  CodeTextLine("  anchorPlacement: Alignment.bottomCenter,"),
                  CodeCommentLine("  # Wo am Menü der Ankerpunkt ist"),
                  CodeTextLine("  placement: Alignment.topCenter,"),
                  CodeCommentLine("  # Dauer, bis das Menü geschlossen wird"),
                  CodeTextLine(
                    "  hoverCloseDelay: const Duration(milliseconds: 500),",
                  ),
                  CodeCommentLine(
                    "  // Da es sich beim SubMenu um eine weitere Layer(Schicht)",
                  ),
                  CodeCommentLine(
                    "  // handelt, wird der hoverCloseDelay benötigt, damit das",
                  ),
                  CodeCommentLine(
                    "  // Menü nicht zu schnell wieder geschlossen wird.",
                  ),
                  CodeCommentLine("  // Empfohlen werden 500 ms."),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Einfache Checkbox',
                example: Checkbox(
                  state: checkState,
                  onChanged: (value) {
                    setState(() {
                      checkState = value;
                    });
                  },
                  trailing: Text(checkState.name),
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeTextLine(
                    "CheckboxState checkState = CheckboxState.unchecked;",
                  ),
                  CodeCommentLine("# Beispiel für einfache Checkbox"),
                  CodeTextLine("Checkbox("),
                  CodeTextLine("  state: checkState,"),
                  CodeTextLine("  onChanged: (value) {"),
                  CodeTextLine("    setState(() {"),
                  CodeTextLine("      checkState = value;"),
                  CodeTextLine("    });"),
                  CodeTextLine("  },"),
                  CodeCommentLine("  # Optionales Label hinter der Checkbox"),
                  CodeTextLine("  trailing: Text(checkState.name),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Checkbox TriState',
                example: Checkbox(
                  state: triCheckState,
                  onChanged: (value) {
                    setState(() {
                      triCheckState = value;
                    });
                  },
                  trailing: Text(triCheckState.name),
                  // Allow toggling: unchecked -> indeterminate -> checked -> ...
                  tristate: true,
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeTextLine(
                    "CheckboxState triCheckState = CheckboxState.unchecked;",
                  ),
                  CodeCommentLine("# Beispiel für TriState Checkbox"),
                  CodeTextLine("Checkbox("),
                  CodeTextLine("  state: triCheckState,"),
                  CodeTextLine("  onChanged: (value) {"),
                  CodeTextLine("    setState(() {"),
                  CodeTextLine("      tricheckState = value;"),
                  CodeTextLine("    });"),
                  CodeTextLine("  },"),
                  CodeCommentLine("  # Optionales Label hinter der Checkbox"),
                  CodeTextLine("  trailing: Text(triCheckState.name),"),
                  CodeCommentLine("  # Tristate: erlaubt mehrere Optionen"),
                  CodeCommentLine(
                    "  # Standard: unchecked -> indeterminate -> checked",
                  ),
                  CodeTextLine("  tristate: true,"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Radio Buttons',
                example: RadioGroup<int>(
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      // Save the selected value emitted by the tapped RadioItem.
                      selectedValue = value;
                    });
                  },
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Each RadioItem represents a single choice with an associated integer value.
                      RadioItem(value: 1, trailing: Text('Option 1')),
                      RadioItem(value: 2, trailing: Text('Option 2')),
                      RadioItem(value: 3, trailing: Text('Option 3')),
                    ],
                  ),
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeTextLine("int? selectedValue;"),
                  CodeCommentLine("# Beispiel für Radio Buttons"),
                  CodeTextLine("RadioGroup<int>("),
                  CodeTextLine("  value: selectedValue,"),
                  CodeTextLine("  onChanged: (value) {"),
                  CodeTextLine("    setState(() {"),
                  CodeTextLine("      selectedValue = value;"),
                  CodeTextLine("    });"),
                  CodeTextLine("  },"),
                  CodeTextLine("  child: const Column("),
                  CodeTextLine(
                    "    crossAxisAlignment: CrossAxisAlignment.start,",
                  ),
                  CodeTextLine("    children: ["),
                  CodeTextLine("      RadioItem("),
                  CodeTextLine("        value: 1,"),
                  CodeTextLine("        trailing: Text('Option 1'),"),
                  CodeTextLine("      ),"),
                  CodeTextLine("      RadioItem("),
                  CodeTextLine("        value: 2,"),
                  CodeTextLine("        trailing: Text('Option 2'),"),
                  CodeTextLine("      ),"),
                  CodeTextLine("      RadioItem("),
                  CodeTextLine("        value: 3,"),
                  CodeTextLine("        trailing: Text('Option 3'),"),
                  CodeTextLine("      ),"),
                  CodeTextLine("    ],"),
                  CodeTextLine("  ),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Radio Cards',
                example: RadioGroup(
                  value: cardValue,
                  onChanged: (value) {
                    setState(() {
                      cardValue = value;
                    });
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioCard(
                        value: 1,
                        child: Basic(
                          title: Text('Option 1'),
                          content: Text('32 GB RAM'),
                        ),
                      ),
                      RadioCard(
                        value: 2,
                        child: Basic(
                          title: Text('Option 2'),
                          content: Text('24 GB RAM'),
                        ),
                      ),
                      RadioCard(
                        value: 3,
                        child: Basic(
                          title: Text('Option 3'),
                          content: Text('16 GB RAM'),
                        ),
                      ),
                    ],
                  ),
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeTextLine("int cardValue = 1;"),
                  CodeCommentLine("# Beispiel für Radio Cards"),
                  CodeTextLine("RadioGroup("),
                  CodeTextLine("  value: cardValue,"),
                  CodeTextLine("  onChanged: (value) {"),
                  CodeTextLine("    setState(() {"),
                  CodeTextLine("      cardValue = value;"),
                  CodeTextLine("    });"),
                  CodeTextLine("  },"),
                  CodeTextLine("  child: const Row("),
                  CodeTextLine("    mainAxisSize: MainAxisSize.min,"),
                  CodeTextLine("    children: ["),
                  CodeTextLine("      RadioCard("),
                  CodeTextLine("        value: 1,"),
                  CodeTextLine("        child: Basic("),
                  CodeTextLine("          title: Text('Option 1'),"),
                  CodeTextLine("          content: Text('32 GB RAM'),"),
                  CodeTextLine("        ),"),
                  CodeTextLine("      ),"),
                  CodeTextLine("      RadioCard("),
                  CodeTextLine("        value: 2,"),
                  CodeTextLine("        child: Basic("),
                  CodeTextLine("          title: Text('Option 2'),"),
                  CodeTextLine("          content: Text('24 GB RAM'),"),
                  CodeTextLine("        ),"),
                  CodeTextLine("      ),"),
                  CodeTextLine("      RadioCard("),
                  CodeTextLine("        value: 3,"),
                  CodeTextLine("        child: Basic("),
                  CodeTextLine("          title: Text('Option 3'),"),
                  CodeTextLine("          content: Text('16 GB RAM'),"),
                  CodeTextLine("        ),"),
                  CodeTextLine("      ),"),
                  CodeTextLine("    ],"),
                  CodeTextLine("  ),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Toggle Switch',
                example: Switch(
                  value: toggleValue,
                  onChanged: (value) {
                    setState(() {
                      toggleValue = value;
                    });
                  },
                  leading: const Text('Option 1'),
                  trailing: const Text('Option 2'),
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeTextLine("bool toggleValue = false;"),
                  CodeCommentLine("# Beispiel für Toggle Switches"),
                  CodeTextLine("Switch("),
                  CodeTextLine("  value: toggleValue,"),
                  CodeTextLine("  onChanged: (value) {"),
                  CodeTextLine("    setState(() {"),
                  CodeTextLine("      toggleValue = value;"),
                  CodeTextLine("    });"),
                  CodeTextLine("  },"),
                  CodeTextLine("  leading: const Text('Option 1'),"),
                  CodeTextLine("  trailing: const Text('Option 2'),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Toggle Switch',
                example: Switch(
                  value: toggleValue,
                  onChanged: (value) {
                    setState(() {
                      toggleValue = value;
                    });
                  },
                  leading: const Text('Option 1'),
                  trailing: const Text('Option 2'),
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeTextLine("bool toggleValue = false;"),
                  CodeCommentLine("# Beispiel für Toggle Switches"),
                  CodeTextLine("Switch("),
                  CodeTextLine("  value: toggleValue,"),
                  CodeTextLine("  onChanged: (value) {"),
                  CodeTextLine("    setState(() {"),
                  CodeTextLine("      toggleValue = value;"),
                  CodeTextLine("    });"),
                  CodeTextLine("  },"),
                  CodeTextLine("  leading: const Text('Option 1'),"),
                  CodeTextLine("  trailing: const Text('Option 2'),"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Slider',
                example: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Slider(
                      max: 2,
                      divisions: 20,
                      value: sliderValue,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    ),
                    const Gap(16),
                    // Show the current numeric value.
                    Text('Wert: ${sliderValue.value}'),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeCommentLine("// Hier wird der initiale Wert des Sliders angegeben (0.5)"),
                  CodeTextLine("SliderValue sliderValue = const SliderValue.single(0.5);"),
                  CodeCommentLine("# Beispiel für Single Slider"),
                  CodeTextLine("Column("),
                  CodeTextLine("  mainAxisSize: MainAxisSize.min,"),
                  CodeTextLine("  children: ["),
                  CodeTextLine("    Slider("),
                  CodeTextLine("      # max und divisions sind optional"),
                  CodeTextLine("      // Erlaube Werte von 0 bis 2 in 20 Schritten."),
                  CodeTextLine("      max: 2,"),
                  CodeTextLine("      divisions: 20,"),
                  CodeTextLine("      value: sliderValue,"),
                  CodeTextLine("      onChanged: (value) {"),
                  CodeTextLine("        setState(() {"),
                  CodeTextLine("          sliderValue = value;"),
                  CodeTextLine("        });"),
                  CodeTextLine("      },"),
                  CodeTextLine("    ),"),
                  CodeTextLine("    const Gap(16),"),
                  CodeTextLine("    Text('Wert: \${sliderValue.value}'),"),
                  CodeTextLine("  ],"),
                  CodeTextLine("),"),
                ],
              ).withPadding(horizontal: 10),
              Gap(20),
              CodeCard(
                title: 'Range Slider',
                example: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Slider(
                      divisions: 20,
                      value: rangeSliderValue,
                      onChanged: (value) {
                        setState(() {
                          rangeSliderValue = value;
                        });
                      },
                    ),
                    const Gap(16),
                    // Display the current ranged values below the slider.
                    Text('Werte: ${rangeSliderValue.start} - ${rangeSliderValue.end}'),
                  ],
                ),
                lines: [
                  CodeCommentLine("# Am Anfang der Klasse angeben"),
                  CodeCommentLine("// Hier werden die initialen Werte des Sliders angegeben (0.5 und 0.75)"),
                  CodeTextLine("SliderValue rangeSliderValue = const SliderValue.ranged(0.5, 0.75);"),
                  CodeCommentLine("# Beispiel für Range Slider"),
                  CodeTextLine("Column("),
                  CodeTextLine("  mainAxisSize: MainAxisSize.min,"),
                  CodeTextLine("  children: ["),
                  CodeTextLine("    Slider("),
                  CodeTextLine("      divisions: 20,"),
                  CodeTextLine("      value: rangeSliderValue,"),
                  CodeTextLine("      onChanged: (value) {"),
                  CodeTextLine("        setState(() {"),
                  CodeTextLine("          rangeSliderValue = value;"),
                  CodeTextLine("        });"),
                  CodeTextLine("      },"),
                  CodeTextLine("    ),"),
                  CodeTextLine("    const Gap(16),"),
                  CodeTextLine("    // Display the current ranged values below the slider."),
                  CodeTextLine("    Text('Werte: \${rangeSliderValue.start} - \${rangeSliderValue.end}'),"),
                  CodeTextLine("  ],"),
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
