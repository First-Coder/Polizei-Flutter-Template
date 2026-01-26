/// Represents a single link entry rendered in the application's footer.
///
/// A footer link can be:
/// - an internal app route (set [route]), or
/// - an external URL (set [url]).
///
/// The UI layer decides how to handle navigation (e.g. `go_router` for routes,
/// `url_launcher` for external URLs).
class FooterLinkModel {
  /// Creates a footer link definition.
  const FooterLinkModel({
    required this.title,
    this.url,
    this.route,
  });

  /// Visible label shown to the user.
  final String title;

  /// External destination URL (opened via browser).
  final String? url;

  /// Internal route name (used by `go_router`, typically with `goNamed`).
  final String? route;
}