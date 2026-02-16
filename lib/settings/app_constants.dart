/// Application-wide constants used for branding and common UI text.
///
/// This class is a simple static holder for values that are referenced in multiple
/// places (e.g. header/footer, layouts).
///
/// Notes:
/// - These values are currently **mutable** (`static String`). If you want to prevent
///   accidental runtime modification, consider making them `static const`.
/// - If the app supports multiple languages, move user-facing strings into an i18n
///   system (e.g. `intl`/ARB) rather than keeping them here.
class AppConstants {
  /// Name of the organization displayed in the UI (e.g. header/footer).
  static String organization = "Berliner Polizei";

  /// Title of the project displayed in the UI (e.g. header).
  static String projectTitle = "Projektname";

  /// Short footer slogan used as a tagline.
  static String footerSlogan = "Sicherheit für Berlin";

  /// Informational footer text shown below the logo/slogan area.
  static String footerInfoText =
      "Die Polizei Berlin ist rund um die Uhr für Ihre Sicherheit im Einsatz. Gemeinsam für eine sichere Hauptstadt.";
}
