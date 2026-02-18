import 'package:police_flutter_template/screens/widgets/alert.dart';
import 'package:police_flutter_template/screens/widgets/code_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Alert;

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 752),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Alert Komponente verwenden').h3,
          CodeCard(
            title: "Alert",
            example: SizedBox(
              width: double.infinity,
              child: Alert(
                backgroundColor: Colors.gray[50],
                backgroundColorDark: Colors.gray[900].withAlpha(100),
                borderColor: Colors.gray[500],
                borderColorDark: Colors.gray[400],
                borderRadius: BorderRadius.circular(8),
                borderWidth: 4,
                child: Basic(
                  leading: Icon(LucideIcons.bell),
                  trailing: Icon(LucideIcons.x),
                  title: Text("Meldung"),
                  content: Text("Dies ist eine Meldung."),
                ),
              ),
            ),
            lines: [
              CodeTextLine("Alert("),
              CodeTextLine("  backgroundColor: Colors.teal[50],"),
              CodeTextLine(
                "  backgroundColorDark: Colors.teal[900].withAlpha(100),",
              ),
              CodeTextLine("  borderColor: Colors.teal[500],"),
              CodeTextLine("  borderColorDark: Colors.teal[400],"),
              CodeTextLine("  borderRadius: BorderRadius.circular(8),"),
              CodeTextLine("  borderWidth: 4,"),
              CodeTextLine("  child: Basic("),
              CodeTextLine("    leading: Icon(LucideIcons.bell),"),
              CodeTextLine("    trailing: Icon(LucideIcons.x),"),
              CodeTextLine("    title: Text('Meldung'),"),
              CodeTextLine("    content: Text('Dies ist eine Meldung.'),"),
              CodeTextLine("  ),"),
              CodeTextLine(");"),
            ],
          ),
          CodeCard(
            title: "Alert.basic",
            description:
                "Beschreibt die Alert Komponente mithilfe der \"basic\" Konfiguration.",
            example: SizedBox(
              width: double.infinity,
              child: Alert.basic(
                backgroundColor: Colors.teal[50],
                backgroundColorDark: Colors.teal[900].withAlpha(100),
                borderColor: Colors.teal[500],
                borderColorDark: Colors.teal[400],
                leading: Icon(LucideIcons.bell),
                trailing: Icon(LucideIcons.x),
                title: "Meldung",
                content: "Dies ist eine Meldung.",
              ),
            ),
            lines: [
              CodeTextLine("Alert.basic("),
              CodeTextLine("  backgroundColor: Colors.teal[50],"),
              CodeTextLine(
                "  backgroundColorDark: Colors.teal[900].withAlpha(100),",
              ),
              CodeTextLine("  borderColor: Colors.teal[500],"),
              CodeTextLine("  borderColorDark: Colors.teal[400],"),
              CodeTextLine("  leading: Icon(LucideIcons.bell),"),
              CodeTextLine("  trailing: Icon(LucideIcons.x),"),
              CodeTextLine("  title: 'Meldung',"),
              CodeTextLine("  content: 'Dies ist eine Meldung.',"),
              CodeTextLine(");"),
            ],
          ),
          Gap(20),
          Text('Vordefinierte Alert Komponenten').h3,
          CodeCard(
            title: "Alert.info",
            description:
                "Beschreibt die Alert Komponente mithilfe der \"info\" Konfiguration.",
            example: SizedBox(
              width: double.infinity,
              child: Alert.info(
                title: "Information",
                content:
                    "Bitte beachten Sie die aktuellen Öffnungszeiten während der Feiertage.",
              ),
            ),
            lines: [
              CodeTextLine("Alert.info("),
              CodeTextLine("  title: 'Information',"),
              CodeTextLine(
                "  content: 'Bitte beachten Sie die aktuellen Öffnungszeiten während der Feiertage.'",
              ),
              CodeTextLine(");"),
            ],
          ),
          CodeCard(
            title: "Alert.success",
            description:
                "Beschreibt die Alert Komponente mithilfe der \"success\" Konfiguration.",
            example: SizedBox(
              width: double.infinity,
              child: Alert.success(
                title: "Erfolgreich",
                content:
                    "Ihre Anfrage wurde erfolgreich bearbeitet und ist nun im System hinterlegt.",
              ),
            ),
            lines: [
              CodeTextLine("Alert.success("),
              CodeTextLine("  title: 'Erfolgreich',"),
              CodeTextLine(
                "  content: 'Ihre Anfrage wurde erfolgreich bearbeitet und ist nun im System hinterlegt.'",
              ),
              CodeTextLine(");"),
            ],
          ),
          CodeCard(
            title: "Alert.warning",
            description:
                "Beschreibt die Alert Komponente mithilfe der \"warning\" Konfiguration.",
            example: SizedBox(
              width: double.infinity,
              child: Alert.warning(
                title: "Warnung",
                content:
                    "Aktuell kommt es zu längeren Wartezeiten. Bitte planen Sie mehr Zeit ein.",
              ),
            ),
            lines: [
              CodeTextLine("Alert.warning("),
              CodeTextLine("  title: 'Warnung',"),
              CodeTextLine(
                "  content: 'Aktuell kommt es zu längeren Wartezeiten. Bitte planen Sie mehr Zeit ein.'",
              ),
              CodeTextLine(");"),
            ],
          ),
          CodeCard(
            title: "Alert.error",
            description:
                "Beschreibt die Alert Komponente mithilfe der \"error\" Konfiguration.",
            example: SizedBox(
              width: double.infinity,
              child: Alert.error(
                title: "Fehler",
                content:
                    "Bei der Verarbeitung ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.",
              ),
            ),
            lines: [
              CodeTextLine("Alert.error("),
              CodeTextLine("  title: 'Fehler',"),
              CodeTextLine(
                "  content: 'Bei der Verarbeitung ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.'",
              ),
              CodeTextLine(");"),
            ],
          ),
        ],
      ).gap(15).withPadding(vertical: 30),
    ).withPadding(horizontal: 20);
  }
}
