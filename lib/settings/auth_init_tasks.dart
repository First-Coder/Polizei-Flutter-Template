import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../bloc/auth/auth_bloc.dart';

/// A single initialization task definition used during app startup.
///
/// The record contains:
/// - `title`: user-facing label displayed while the task runs
/// - `action`: async callback that returns `true` on success, `false` on failure
///
/// The `action` is intentionally a `Future<bool> Function()` to support:
/// - sequential execution
/// - progress UIs
/// - retry logic
typedef InitTask = ({String title, Future<bool> Function() action});

/// Provides the list of initialization tasks for the authentication/startup flow.
///
/// Typical usage:
/// - An initialization screen iterates over [tasks], displays each [InitTask.title],
///   executes [InitTask.action], and decides whether to proceed or show an error.
///
/// Why this class needs a [BuildContext]:
/// - It reads dependencies from the widget tree (e.g. [AuthBloc]) via `context.read<T>()`.
///
/// Notes / design considerations:
/// - The task titles are currently German strings; consider i18n if needed.
/// - The sample tasks include artificial delays to simulate real startup work.
/// - If you need testability, consider injecting the dependencies (AuthBloc/service)
///   rather than reading them directly from context.
class AuthInitTasks {
  /// Creates an initialization task provider bound to the given [context].
  const AuthInitTasks({required this.context});

  /// The widget tree context used to access dependencies (e.g. BLoCs).
  final BuildContext context;

  /// List of startup tasks executed in order.
  ///
  /// Task 1 triggers the authentication check by dispatching [Login] on [AuthBloc]
  /// and waits until the bloc emits either [Authorized] or [NotAuthorized].
  ///
  /// The following tasks are demo placeholders that simulate loading configuration
  /// and establishing a database connection.
  List<InitTask> get tasks => [
    (
      title: 'Authentifizierung wird geprüft',
      action: () async {
        final authBloc = context.read<AuthBloc>();

        // Trigger the authentication check (implementation depends on AuthBloc).
        authBloc.add(Login());

        // Wait for a terminal auth result.
        final state = await authBloc.stream.firstWhere(
          (state) => state is Authorized || state is NotAuthorized,
        );
        return state is Authorized;
      },
    ),
    (
      title: 'Systemkonfiguration wird geladen',
      action: () async {
        // Placeholder for loading remote config / feature flags / app settings.
        await Future.delayed(const Duration(seconds: 1));
        return true;
      },
    ),
    (
      title: 'Datenbank-Verbindung herstellen',
      action: () async {
        // Placeholder for connecting to an API, database, or backend service.
        await Future.delayed(const Duration(milliseconds: 500));
        return true;
      },
    ),
  ];
}
