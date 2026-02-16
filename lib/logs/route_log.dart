import 'package:talker_flutter/talker_flutter.dart';

/// A structured log entry for route/navigation diagnostics using `talker_flutter`.
///
/// This log is intended to be emitted from routing code (e.g. `go_router` redirect hooks)
/// to provide a consistent, readable snapshot of the navigation context.
///
/// Typical usage:
/// - Create a [RouteLog] with the relevant `GoRouterState` values and emit it via:
///   `talker.logCustom(RouteLog(...))`.
///
/// What it captures:
/// - [navigateTo]: the target URI the router is currently evaluating
/// - [fullPath]: the full path pattern (may be null depending on router state)
/// - [matchedLocation]: the location matched by the router
/// - [name]: the route name (or a placeholder if unnamed)
/// - [pathParameters]: route path parameters (e.g. `:id`)
/// - [lastKnownRoute]: app-specific recovery hint (e.g. for hot reload restoration)
///
/// Styling:
/// - Uses a custom [AnsiPen] color (xterm 135) to make route logs easy to spot in output.
/// - Uses [TalkerKey.route] so logs can be filtered/grouped by "route" category.
class RouteLog extends TalkerLog {
  /// Terminal color styling for this log entry.
  @override
  AnsiPen? get pen => AnsiPen()..xterm(135);

  /// Category key for filtering/grouping within Talker.
  @override
  String? get key => TalkerKey.route;

  /// Creates a route diagnostics log message.
  ///
  /// All parameters are required except [fullPath] and [lastKnownRoute], which may be null
  /// depending on router state and app navigation history.
  RouteLog({
    required Uri navigateTo,
    required String? fullPath,
    required String matchedLocation,
    required String name,
    required Map<String, String> pathParameters,
    required String? lastKnownRoute,
  }) : super(
         _createMessage(
           navigateTo,
           fullPath,
           matchedLocation,
           name,
           pathParameters,
           lastKnownRoute,
         ),
       );

  /// Builds the human-readable multi-line message for the log.
  ///
  /// We use a `StringBuffer` for efficient concatenation and consistent formatting.
  static String _createMessage(
    Uri navigateTo,
    String? fullPath,
    String matchedLocation,
    String name,
    Map<String, String> pathParameters,
    String? lastKnownRoute,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('Navigating check triggered to: $navigateTo');
    buffer.writeln('  Full path: $fullPath');
    buffer.writeln('  Matched location: $matchedLocation');
    buffer.writeln('  Name: $name');
    buffer.writeln('  Path params: $pathParameters');
    buffer.write('  Last known route: $lastKnownRoute');
    return buffer.toString();
  }
}
