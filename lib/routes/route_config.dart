import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/routes/route_names.dart';
import 'package:police_flutter_template/screens/auth/auth_not_initialized_screen.dart';
import 'package:police_flutter_template/screens/components/alerts/alerts_screen.dart';
import 'package:police_flutter_template/screens/components/buttons/buttons_screen.dart';
import 'package:police_flutter_template/screens/components/cards/cards_screen.dart';
import 'package:police_flutter_template/screens/components/forms/forms_screen.dart';
import 'package:police_flutter_template/screens/components/lists/lists_screen.dart';
import 'package:police_flutter_template/screens/error_pages/internal_server_error_screen.dart';
import 'package:police_flutter_template/screens/error_pages/not_found_screen.dart';
import 'package:police_flutter_template/screens/home/home_screen.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../bloc/auth/auth_bloc.dart';
import '../logs/route_log.dart';
import '../screens/error_pages/not_authorized_screen.dart';
import '../screens/widgets/layouts/main_layout.dart';
import 'cubit/router_cubit.dart';

/// Root navigator key used by [GoRouter] for top-level navigation.
///
/// This is typically required when you want to:
/// - Control the top-most navigator (dialogs, full-screen pages)
/// - Use nested navigation (e.g. shell routes) while keeping a stable root
final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Application routing configuration based on `go_router`.
///
/// This class wires together:
/// - Route names/paths from [RouteNames]
/// - Auth-based redirects based on [AuthBloc]
/// - "Last known route" recovery based on [RouterCubit] (useful during hot reload)
/// - Route transition logging via `talker` and [TalkerRouteObserver]
class RouteConfig {
  /// Creates and returns the application's router.
  ///
  /// [talker] is used for route logging and diagnostics.
  ///
  /// Redirect behavior:
  /// - If auth is not initialized, the user is sent to the initialize route,
  ///   with a `from` query parameter containing the originally requested path.
  /// - If authorized and currently at the initialize location, the router may
  ///   redirect to [RouterCubit.lastKnownRoute] to restore navigation state.
  static GoRouter returnRouter(Talker talker) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,

      /// The app starts at the initialization route.
      initialLocation: RouteNames.initializeUrl,

      /// Observers can log route transitions (e.g. for debugging/analytics).
      observers: [TalkerRouteObserver(talker)],
      errorPageBuilder: (context, state) {
        // Fallback page used when GoRouter cannot match a route.
        return MaterialPage(
          key: state.pageKey,
          child: Scaffold(child: NotFoundScreen()),
        );
      },

      /// Central redirect hook.
      ///
      /// Note: Keep redirect logic minimal and avoid loops. Prefer state-driven
      /// routing decisions (e.g. based on auth/router cubits) and return `null`
      /// whenever no redirect is required.
      redirect: (BuildContext context, GoRouterState state) async {
        // Encode the "from" path so we can return after initialization/login.
        final from = Uri.encodeComponent(state.fullPath ?? RouteNames.homeUrl);

        // Read required state managers from the widget tree.
        final authBloc = context.read<AuthBloc>();
        final routerCubit = context.read<RouterCubit>();

        // Log navigation intent + lastKnownRoute for troubleshooting.
        talker.logCustom(
          RouteLog(
            navigateTo: state.uri,
            fullPath: state.fullPath,
            matchedLocation: state.matchedLocation,
            name: state.name ?? 'N/A',
            pathParameters: state.pathParameters,
            lastKnownRoute: routerCubit.lastKnownRoute,
          ),
        );

        // Important: Avoid redirect loops!
        // If the router is already trying to navigate to the load known route, do nothing.
        if (routerCubit.lastKnownRoute != null &&
            state.matchedLocation == routerCubit.lastKnownRoute) {
          talker.debug(
            '[ROUTER_REDIRECT] Already at or targeting last known valid route. No redirect for: ${state.uri}',
          );
          return null;
        }

        // Example for skip check url's
        // if (state.uri.path == RouteNames.loginUrl ||
        //     state.uri.path == RouteNames.registerUrl) {
        //   return null;
        // }

        // Not yet initialized: stay within initialization flow.
        if (authBloc.state is AuthNotInitialized) {
          return '${RouteNames.initializeUrl}?from=$from';
        }

        // If authorized and currently at initialLocation, attempt to restore
        // the last known valid route (useful e.g. after hot reload).
        if (authBloc.state is Authorized && // Ensure we are logged in
            state.uri.path ==
                RouteNames
                    .initializeUrl && // Router is currently at initialLocation
            routerCubit.lastKnownRoute != null) {
          if (kDebugMode) {
            talker.info(
              '[ROUTER_REDIRECT] Redirecting due Authorized and at initialLocation, but have a lastKnownRoute.\n'
              '  From: ${state.uri}\n'
              '  To: ${routerCubit.lastKnownRoute}',
            );
          }

          // Important: Ensure this route actually exists and is reachable!
          final String targetRoute = routerCubit.lastKnownRoute!;
          return targetRoute;
        }

        talker.debug(
          '[ROUTER_REDIRECT] No redirect performed for: ${state.uri}',
        );

        return null;
      },
      routes: [
        GoRoute(
          name: RouteNames.initialize,
          path: RouteNames.initializeUrl,

          /// Initialization screen runs startup tasks and navigates afterwards.
          builder: (context, state) => const AuthNotInitializedScreen(),
        ),
        GoRoute(
          name: RouteNames.notFound,
          path: RouteNames.notFoundUrl,
          builder: (context, state) => NotFoundScreen(),
        ),
        GoRoute(
          name: RouteNames.notAuthorized,
          path: RouteNames.notAuthorizedUrl,
          builder: (context, state) => NotAuthorizedScreen(),
        ),
        GoRoute(
          name: RouteNames.internalServerError,
          path: RouteNames.internalServerErrorUrl,
          builder: (context, state) => InternalServerErrorScreen(),
        ),
        StatefulShellRoute.indexedStack(
          /// Provides a persistent shell layout (e.g. app bar) around branches.
          builder: (context, state, navigationShell) =>
              MainLayout(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RouteNames.home,
                  path: RouteNames.homeUrl,
                  builder: (context, state) => HomeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RouteNames.buttons,
                  path: RouteNames.buttonsUrl,
                  builder: (context, state) => ButtonsScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RouteNames.alerts,
                  path: RouteNames.alertsUrl,
                  builder: (context, state) => AlertsScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RouteNames.cards,
                  path: RouteNames.cardsUrl,
                  builder: (context, state) => CardsScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RouteNames.lists,
                  path: RouteNames.listsUrl,
                  builder: (context, state) => ListsScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RouteNames.forms,
                  path: RouteNames.formsUrl,
                  builder: (context, state) => FormsScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
