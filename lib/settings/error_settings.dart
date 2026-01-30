import 'package:police_flutter_template/routes/route_names.dart';

class ErrorSettings {
  static String notFoundHomeLink = RouteNames.home;

  static List<String> notFoundReasons = [
    "Die URL wurde falsch eingegeben",
    "Die Seite wurde gelöscht oder verschoben",
    "Der Link ist veraltet oder ungültig",
  ];

  static String accessInformationHomeLink = RouteNames.home;

  static List<String> accessInformations = [
    "Diese Seite ist nur für autorisierte Benutzer zugänglich",
    "Ihre Anmeldedaten haben nicht die erforderlichen Berechtigungen",
    "Wenden Sie sich an Ihren Administrator für Zugriff",
  ];

  static String internalServerErrorHomeLink = RouteNames.home;

  static List<String> internalServerErrorWhatHappend = [
    "Ein technischer Fehler ist auf dem Server aufgetreten",
    "Ihre Anfrage konnte nicht verarbeitet werden",
    "Das Problem wurde automatisch an unser IT-Team gemeldet",
  ];

  static List<String> internalServerErrorHelp = [
    "Laden Sie die Seite neu",
    "Versuchen Sie es in einigen Minuten erneut",
    "Kehren Sie zur Startseite zurück",
  ];
}
