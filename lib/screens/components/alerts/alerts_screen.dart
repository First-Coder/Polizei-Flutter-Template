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
          Text('Alert Komponente verwenden').h4,
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
          Text('Vordefinierte Alert Komponenten').h4,
          Gap(10),
          Alert.info(
            title: "Information",
            content:
                "Bitte beachten Sie die aktuellen Öffnungszeiten während der Feiertage.",
          ),

          Alert.success(
            title: "Erfolgreich",
            content:
                "Ihre Anfrage wurde erfolgreich bearbeitet und ist nun im System hinterlegt.",
          ),
          Gap(10),
          Gap(20),
          Alert.error(
            title: "Warnung",
            content:
                "Aktuell kommt es zu längeren Wartezeiten. Bitte planen Sie mehr Zeit ein.",
          ),
          Gap(10),
          Gap(20),
          Alert.warning(
            title: "Fehler",
            content:
                "Bei der Verarbeitung ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.",
          ),
        ],
      ).gap(10).withPadding(vertical: 30),
    ).withPadding(horizontal: 20);
  }
}
