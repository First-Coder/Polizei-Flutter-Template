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
          Gap(32),
          Text('Alert Komponente verwenden').h4,
          Gap(10),
          Alert.basic(
            backgroundColor: Colors.teal[50],
            backgroundColorDark: Colors.teal[900].withAlpha(100),
            borderColor: Colors.teal[500],
            borderColorDark: Colors.teal[400],
            leading: Icon(LucideIcons.bell),
            trailing: Icon(LucideIcons.x),
            title: "Meldung",
            content: "Dies ist eine Meldung.",
          ),
          Gap(10),
          CodeCard(lines: []),
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
          Gap(32),
        ],
      ),
    ).withPadding(horizontal: 20);
  }
}
