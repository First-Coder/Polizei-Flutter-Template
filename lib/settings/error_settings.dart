import 'package:police_flutter_template/routes/route_names.dart';

/// Configuration for error pages (copy + navigation targets).
///
/// This class centralizes:
/// - Which route should be used as the "Back to home" destination.
/// - Human-readable lists of reasons/help text shown on error screens.
///
/// Note:
/// - The text values are currently in German. If your app is localized,
///   consider migrating these to a proper i18n solution (e.g. `intl`/ARB).
/// - All fields are static and mutable; if you want safer config, consider
///   using `const`/immutable models.
class ErrorSettings {
  /// Route name used by the "Not Found" screen as a home link target.
  static String notFoundHomeLink = RouteNames.home;

  /// Possible reasons shown on the "Not Found" screen.
  static List<String> notFoundReasons = [
    "Die URL wurde falsch eingegeben",
    "Die Seite wurde gelöscht oder verschoben",
    "Der Link ist veraltet oder ungültig",
  ];

  /// Route name used by the "Not Authorized" screen as a home link target.
  static String accessInformationHomeLink = RouteNames.home;

  /// Explanations shown on the "Not Authorized" screen.
  static List<String> accessInformations = [
    "Diese Seite ist nur für autorisierte Benutzer zugänglich",
    "Ihre Anmeldedaten haben nicht die erforderlichen Berechtigungen",
    "Wenden Sie sich an Ihren Administrator für Zugriff",
  ];

  /// Route name used by the "Internal Server Error" screen as a home link target.
  static String internalServerErrorHomeLink = RouteNames.home;

  /// Explanations shown when an internal server error occurred.
  static List<String> internalServerErrorWhatHappend = [
    "Ein technischer Fehler ist auf dem Server aufgetreten",
    "Ihre Anfrage konnte nicht verarbeitet werden",
    "Das Problem wurde automatisch an unser IT-Team gemeldet",
  ];

  /// Suggested actions shown to help the user recover from an internal server error.
  static List<String> internalServerErrorHelp = [
    "Laden Sie die Seite neu",
    "Versuchen Sie es in einigen Minuten erneut",
    "Kehren Sie zur Startseite zurück",
  ];
}
