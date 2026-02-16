import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/auth/auth_not_initialized_screen.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../routes/cubit/router_cubit.dart';
import '../../../routes/route_names.dart';

/// A layout wrapper that:
/// - Observes authentication state ([AuthBloc])
/// - Persists the current route as "last known route" ([RouterCubit])
/// - Optionally shows the initialization/auth bootstrap screen while auth is not ready
///
/// Intended usage:
/// - Wrap the app's page tree so route persistence and auth gating are handled
///   in one central place.
///
/// Responsibilities:
/// 1) **Auth gating**
///    - If the auth state is [AuthNotInitialized], render [AuthNotInitializedScreen].
///    - Otherwise, render [child].
///
/// 2) **Route persistence**
///    - Listens to `GoRouter.routeInformationProvider` and stores the current URI
///      in [RouterCubit] (except the initialize route).
///
/// 3) **Lifecycle refresh**
///    - On app resume, dispatches [LoadAuthentication] to re-check auth.
///
/// Notes:
/// - There is commented code showing how to integrate additional providers with
///   `MultiBlocProvider`. If your app grows, consider enabling that and providing
///   feature BLoCs here.
/// - This widget registers a router listener dynamically in [didChangeDependencies]
///   to ensure it uses the correct `GoRouter` instance.
class MultiProviderLayout extends StatefulWidget {
  /// Creates the layout wrapper.
  const MultiProviderLayout({super.key, required this.child});

  /// The page tree shown when authentication is ready.
  final Widget child;

  @override
  State<MultiProviderLayout> createState() => _MultiProviderLayoutState();
}

class _MultiProviderLayoutState extends State<MultiProviderLayout>
    with WidgetsBindingObserver {
  /// The auth bloc instance read from the widget tree.
  late AuthBloc authBloc;

  /// Cached current auth state to decide what to render.
  late AuthState state;

  /// Cached router instance to manage adding/removing listeners safely.
  GoRouter? _router;

  /// Listener attached to `routeInformationProvider` for route persistence.
  VoidCallback? _routerListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Load auth states.
    authBloc = context.read<AuthBloc>();
    state = authBloc.state;

    // Keep local state in sync with bloc emissions.
    authBloc.stream.listen(_checkAuthentication);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ensure we are listening to the correct GoRouter instance.
    final router = GoRouter.of(context);
    if (_router == router) return;

    // Remove old listener (if any).
    if (_routerListener != null && _router != null) {
      _router!.routeInformationProvider.removeListener(_routerListener!);
    }

    _router = router;

    // Persist the current URI whenever GoRouter updates it.
    _routerListener = () {
      if (!mounted) return;

      final uri = _router!.routeInformationProvider.value.uri;

      // Do not persist the initialize route (it is transient and would cause loops).
      if (uri.toString() == RouteNames.initializeUrl) {
        return;
      }

      context.read<RouterCubit>().storeCurrentRoute(uri.toString());
    };

    _router!.routeInformationProvider.addListener(_routerListener!);

    // Store the initial value immediately as well.
    final initialUri = _router!.routeInformationProvider.value.uri;
    if (initialUri.toString() == RouteNames.initializeUrl) {
      return;
    }
    context.read<RouterCubit>().storeCurrentRoute(initialUri.toString());
  }

  /// Updates local auth state and optionally triggers navigation decisions.
  ///
  /// Currently, this only updates internal state and contains a placeholder for
  /// not-authorized navigation.
  void _checkAuthentication(AuthState newState) {
    if (!mounted) return;

    setState(() {
      state = newState;
    });

    if (newState is NotAuthorized) {
      // TODO: Navigate to not authorized.
      // Example:
      // context.pushNamed(RouteNames.notAuthorized);
    }
  }

  @override
  void dispose() {
    // Detach router listener to avoid leaks.
    if (_routerListener != null && _router != null) {
      _router!.routeInformationProvider.removeListener(_routerListener!);
    }

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // On resume, re-check authentication to ensure session is still valid.
    if (state == AppLifecycleState.resumed) {
      authBloc.add(LoadAuthentication());
    }
  }

  @override
  Widget build(BuildContext context) {
    /// If you want to use bloc providers inside your application, you
    /// can uncomment this section and add your providers here.
    // return MultiBlocProvider(
    //   providers: [
    //     // Add all the providers here
    //   ],
    //   child: state is AuthNotInitialized
    //       ? AuthNotInitializedScreen()
    //       : widget.child,
    // );

    // Gate the app until authentication/startup tasks are completed.
    return state is AuthNotInitialized
        ? AuthNotInitializedScreen()
        : widget.child;
  }
}
