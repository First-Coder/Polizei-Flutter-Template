import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/auth/auth_not_initialized_screen.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../routes/cubit/router_cubit.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Load router store
    GoRouter.of(context).routerDelegate.addListener(() {
      if (!mounted) return;
      final currentConfiguration = GoRouter.of(
        context,
      ).routerDelegate.currentConfiguration;
      context.read<RouterCubit>().storeCurrentRoute(
        currentConfiguration.uri.toString(),
      );
    });

    // Load auth cubit states
    authBloc = context.read<AuthBloc>();
    state = authBloc.state;
    authBloc.stream.listen(_checkAuthentication);
  }

  /// Check the authentication state
  void _checkAuthentication(AuthState newState) {
    if (!mounted) return;

    setState(() {
      state = newState;
    });

    if (newState is NotAuthorized) {
      // TODO: Navigate to not authorized
      // context.goNamed(RouteNames.login);
    }
  }

  @override
  void dispose() {
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
