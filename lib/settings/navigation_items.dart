import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/navigation_item_model.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide NavigationItem;

import '../routes/route_names.dart';

/// Factory/provider for the application's navigation tree.
///
/// This class builds lists of [NavigationItemModel] that can be rendered by a layout
/// (e.g. sidebar, drawer, or top navigation).
///
/// Key concepts:
/// - Items can be **leaf nodes** (with [NavigationItemModel.onPressed]) or
///   **group nodes** (with [NavigationItemModel.children]).
/// - Navigation can be performed either by:
///   - switching a `StatefulShellRoute` branch via [StatefulNavigationShell.goBranch], or
///   - pushing standalone routes via `go_router` (e.g. `context.pushNamed(...)`).
///
/// Why it needs a [BuildContext]:
/// - Some actions use `go_router` APIs on the current context.
///
/// Name collision note:
/// - `shadcn_flutter` also defines a `NavigationItem`. The import hides it to avoid
///   clashes with the local model naming.
class NavigationItems {
  /// Creates a navigation item provider for the given [context] and [navigationShell].
  const NavigationItems({required this.context, required this.navigationShell});

  /// Context used to build route callbacks.
  final BuildContext context;

  /// The navigation shell used for branch-based navigation (IndexedStack).
  final StatefulNavigationShell navigationShell;

  /// If true, the UI may prefer top navigation over a sidebar (based on width).
  ///
  /// This is a simple configuration flag used by layouts.
  final useTopNavigation = true;

  /// Breakpoint width (in logical pixels) where the UI may switch to top navigation.
  final topNavigationBreakWidth = 900;

  /// Profile-related navigation items (typically shown in a user/profile menu).
  ///
  /// Note: These currently have no actions attached (index is null, onPressed is null),
  /// so the consuming UI decides what to do (or they are placeholders).
  List<NavigationItemModel> get profileItems => [
    NavigationItemModel(index: null, title: "Mein Profil"),
    NavigationItemModel(index: null, title: "Einstellungen"),
  ];

  /// Main navigation items for the app.
  ///
  /// Current structure:
  /// - Home branch (index 0)
  /// - Components group, containing:
  ///   - Buttons branch (index 1)
  ///   - Standalone error pages (404/403/500) navigated via named routes
  /// - External documentation link (opens in browser)
  List<NavigationItemModel> get items => [
    NavigationItemModel(
      index: 0,
      title: "Home",
      icon: const Icon(LucideIcons.house),
      onPressed: () => navigationShell.goBranch(0, initialLocation: false),
    ),
    NavigationItemModel(
      index: null,
      title: "Components",
      children: [
        NavigationItemModel(
          index: 1,
          title: "Buttons",
          icon: const Icon(LucideIcons.component),
          onPressed: () => navigationShell.goBranch(1, initialLocation: false),
        ),
        NavigationItemModel(
          index: 2,
          title: "Alerts",
          icon: const Icon(LucideIcons.circleAlert),
          onPressed: () => navigationShell.goBranch(2, initialLocation: false),
        ),
        NavigationItemModel(
          index: 3,
          title: "Cards",
          icon: const Icon(LucideIcons.component),
          onPressed: () => navigationShell.goBranch(3, initialLocation: false),
        ),
        NavigationItemModel(
          index: null,
          title: "404 Nicht gefunden - Standalone",
          icon: const Icon(LucideIcons.fileQuestion),
          onPressed: () => context.pushNamed(RouteNames.notFound),
        ),
        NavigationItemModel(
          index: null,
          title: "403 Nicht autorisiert - Standalone",
          icon: const Icon(LucideIcons.fileQuestion),
          onPressed: () => context.pushNamed(RouteNames.notAuthorized),
        ),
        NavigationItemModel(
          index: null,
          title: "500 Internal Server Error - Standalone",
          icon: const Icon(LucideIcons.serverCrash),
          onPressed: () => context.pushNamed(RouteNames.internalServerError),
        ),
      ],
    ),
    NavigationItemModel(
      index: null,
      icon: const Icon(LucideIcons.code),
      title: "Flutter ShadCn",
      url: "https://sunarya-thito.github.io/shadcn_flutter/",
      isExternal: true,
    ),
  ];
}
