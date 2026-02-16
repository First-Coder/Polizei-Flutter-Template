import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:police_flutter_template/screens/app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Application entrypoint.
///
/// Responsibilities:
/// - Ensure Flutter bindings are initialized before any platform/plugin calls.
/// - Configure logging using `talker` and connect it to `flutter_bloc` via [Bloc.observer].
/// - Register shared services (currently [Talker]) in the `GetIt` service locator.
/// - Launch the root widget ([App]).
///
/// Notes:
/// - `TalkerBlocObserver` provides logging for BLoC events/transitions, which is useful
///   during development and debugging.
/// - Dependency injection is intentionally minimal here; for larger apps you might
///   centralize registrations in a dedicated DI/bootstrap file.
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register logging.
  final talker = Talker(
    settings: TalkerSettings(
      // Example customization:
      // colors: {
      //   TalkerLogType.blocEvent.key: AnsiPen()..red(),
      //   TalkerLogType.blocTransition.key: AnsiPen()..yellow(),
      // },
    ),
  );

  // Log bloc lifecycle events (events, transitions, errors).
  Bloc.observer = TalkerBlocObserver(talker: talker);

  // Setup dependency injection.
  final getIt = GetIt.instance;
  getIt.registerSingleton<Talker>(talker);

  // Start the app.
  runApp(const App());
}
