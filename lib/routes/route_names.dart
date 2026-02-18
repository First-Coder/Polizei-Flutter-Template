/// Central place for named routes and their corresponding URL paths.
///
/// This class holds:
/// - **Route names** used with routers (e.g. `GoRoute.name`)
/// - **URL paths** (leading `/`) used with routers (e.g. `GoRoute.path`)
///
/// Keeping these values in one place prevents typos and makes refactoring easier.
/// Prefer referencing these constants instead of hardcoding strings throughout the app.
class RouteNames {
  /// Route name for the initialization flow/screen.
  static const String initialize = "initialize";

  /// URL path for the initialization route (e.g. `/initialize`).
  static const String initializeUrl = '/$initialize';

  /// Route name for the home screen.
  static const String home = "home";

  /// URL path for the home route (e.g. `/home`).
  static const String homeUrl = '/$home';

  // Error pages

  /// Route name for the "not found" (404) page.
  static const String notFound = "not-found";

  /// URL path for the "not found" route (e.g. `/not-found`).
  static const String notFoundUrl = '/$notFound';

  /// Route name for the "not authorized" (403) page.
  static const String notAuthorized = "not-authorized";

  /// URL path for the "not authorized" route (e.g. `/not-authorized`).
  static const String notAuthorizedUrl = '/$notAuthorized';

  /// Route name for the "internal server error" (500) page.
  static const String internalServerError = "internal-server-error";

  /// URL path for the "internal server error" route (e.g. `/internal-server-error`).
  static const String internalServerErrorUrl = '/$internalServerError';

  // Components

  /// Route name for the "buttons" component showcase/demo screen.
  static const String buttons = "buttons";

  /// URL path for the buttons demo route (e.g. `/buttons`).
  static const String buttonsUrl = '/$buttons';

  /// Route name for the "alerts" component showcase/demo screen.
  static const String alerts = "alerts";

  /// URL path for the alerts demo route (e.g. `/alerts`).
  static const String alertsUrl = '/$alerts';

  /// Route name for the "cards" component showcase/demo screen.
  static const String cards = "cards";

  /// URL path for the cards demo route (e.g. `/cards`).
  static const String cardsUrl = '/$cards';

  /// Route name for the "lists" component showcase/demo screen.
  static const String lists = "lists";

  /// URL path for the lists demo route (e.g. `/lists`).
  static const String listsUrl = '/$lists';
}
