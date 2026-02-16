import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:police_flutter_template/settings/app_constants.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../bloc/auth/auth_bloc.dart';
import '../routes/cubit/router_cubit.dart';
import '../routes/route_config.dart';
import '../theme/cubit/theme_cubit.dart';

/// Root application widget.
///
/// This widget wires together the app's foundational infrastructure:
/// - Dependency access (via `GetIt`) for shared services like logging ([Talker]).
/// - Global state management using BLoCs/Cubits (theme, router persistence, auth).
/// - Theme binding: rebuilds the app when [ThemeCubit] emits a new [ThemeState].
/// - Router setup using `go_router` (provided by [RouteConfig]).
///
/// Why it's stateful:
/// - Implements [WidgetsBindingObserver] so the app can later react to lifecycle changes
///   (e.g. to sync system theme, refresh tokens, pause services). The current implementation
///   only registers/unregisters the observer.
class App extends StatefulWidget {
  /// Creates the root application widget.
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

/// State for [App].
///
/// Uses [WidgetsBindingObserver] to enable reacting to lifecycle changes in the future.
/// Currently, no lifecycle callbacks are overridden beyond registering the observer.
class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // Register as a WidgetsBindingObserver to be able to respond to app lifecycle
    // events (foreground/background, platform brightness changes, etc.).
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the app-wide logger instance from the service locator.
    final talker = GetIt.instance.get<Talker>();

    return MultiBlocProvider(
      providers: [
        // Theme should be available immediately, so it's created eagerly.
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit(), lazy: false),

        // RouterCubit persists last known route; eager init helps early redirects.
        BlocProvider<RouterCubit>(create: (_) => RouterCubit(), lazy: false),

        // AuthBloc can be lazy (depending on your app needs). Here it is created normally.
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        // Rebuild the app when theme changes (light <-> dark).
        builder: (context, state) => ShadcnApp.router(
          title: '${AppConstants.projectTitle} | ${AppConstants.organization}',
          theme: state.themeData,
          debugShowCheckedModeBanner: false,

          // Central router configuration (routes + redirects + logging).
          routerConfig: RouteConfig.returnRouter(talker),
        ),
      ),
    );
  }
}
