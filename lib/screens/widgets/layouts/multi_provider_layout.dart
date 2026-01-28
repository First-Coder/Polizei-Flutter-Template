import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/auth/auth_not_initialized_screen.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../routes/cubit/router_cubit.dart';
import '../../../routes/route_names.dart';

class MultiProviderLayout extends StatefulWidget {
  const MultiProviderLayout({super.key, required this.child});

  final Widget child;

  @override
  State<MultiProviderLayout> createState() => _MultiProviderLayoutState();
}

class _MultiProviderLayoutState extends State<MultiProviderLayout>
    with WidgetsBindingObserver {
  /// The cubit states
  late AuthBloc authBloc;

  /// The current state
  late AuthState state;

  GoRouter? _router;
  VoidCallback? _routerListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Load router store
    // GoRouter.of(context).routerDelegate.addListener(() {
    //   if (!mounted) return;
    //   final currentConfiguration = GoRouter.of(
    //     context,
    //   ).routerDelegate.currentConfiguration;
    //   context.read<RouterCubit>().storeCurrentRoute(
    //     currentConfiguration.uri.toString(),
    //   );
    // });

    // Load auth cubit states
    authBloc = context.read<AuthBloc>();
    state = authBloc.state;
    authBloc.stream.listen(_checkAuthentication);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final router = GoRouter.of(context);
    if (_router == router) return;

    // remove old listener (if any)
    if (_routerListener != null && _router != null) {
      _router!.routeInformationProvider.removeListener(_routerListener!);
    }

    _router = router;
    _routerListener = () {
      if (!mounted) return;

      final uri = _router!.routeInformationProvider.value.uri;
      if(uri.toString() == RouteNames.initializeUrl) {
        return;
      }
      context.read<RouterCubit>().storeCurrentRoute(uri.toString());
    };

    _router!.routeInformationProvider.addListener(_routerListener!);

    // Store initial value immediately as well
    final initialUri = _router!.routeInformationProvider.value.uri;
    if(initialUri.toString() == RouteNames.initializeUrl) {
      return;
    }
    context.read<RouterCubit>().storeCurrentRoute(initialUri.toString());
  }

  /// Check the authentication state
  void _checkAuthentication(AuthState newState) {
    if (!mounted) return;

    setState(() {
      state = newState;
    });

    if (newState is NotAuthorized) {
      // TODO: Navigate to not authorized
      // context.pushNamed(RouteNames.login);
    }
  }

  @override
  void dispose() {
    if (_routerListener != null && _router != null) {
      _router!.routeInformationProvider.removeListener(_routerListener!);
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      authBloc.add(LoadAuthentication());
    }
  }

  @override
  Widget build(BuildContext context) {
    /// If you want to use bloc provider´s inside your application, you
    /// need to uncomment this section and add your providers here
    // return MultiBlocProvider(
    //   providers: [
    //     // Add all the providers here
    //   ],
    //   child: state is AuthNotInitialized
    //       ? AuthNotInitializedScreen()
    //       : widget.child,
    // );
    return state is AuthNotInitialized
        ? AuthNotInitializedScreen()
        : widget.child;
  }
}
