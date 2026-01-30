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
}
