import 'package:talker_flutter/talker_flutter.dart';

class RouteLog extends TalkerLog {
  @override
  AnsiPen? get pen => AnsiPen()..xterm(135);

  @override
  String? get key => TalkerKey.route;

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

  /// Create a message to log.
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
