import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../bloc/auth/auth_bloc.dart';

/// Typedef for the initialisation tasks
typedef InitTask = ({String title, Future<bool> Function() action});

/// Class to define the initialisation tasks
class AuthInitTasks {
  const AuthInitTasks({required this.context});

  /// The current context
  final BuildContext context;

  /// Definition of the Initialisierungs-Tasks
  List<InitTask> get tasks => [
    (
      title: 'Authentifizierung wird geprüft',
      action: () async {
        final authBloc = context.read<AuthBloc>();

        // Login event will be executed
        authBloc.add(Login());

        final state = await authBloc.stream.firstWhere(
          (state) => state is Authorized || state is NotAuthorized,
        );
        return state is Authorized;
      },
    ),
    (
      title: 'Systemkonfiguration wird geladen',
      action: () async {
        await Future.delayed(const Duration(seconds: 1));
        return true;
      },
    ),
    (
      title: 'Datenbank-Verbindung herstellen',
      action: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        return true;
      },
    ),
  ];
}
