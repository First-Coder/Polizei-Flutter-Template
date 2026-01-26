import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/navigation_item_model.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide NavigationItem;

import '../routes/route_names.dart';

/// Factory/provider for the application's navigation tree.
///
/// This class builds a list of [NavigationItemModel] definitions that can be rendered
/// by a layout (e.g. sidebar/drawer).
///
/// Why it needs a [BuildContext]:
/// The navigation actions use `go_router` (e.g. `context.goNamed(...)`), so the
/// current widget context is required to build [onPressed] callbacks.
///
/// Note:
/// `shadcn_flutter` also defines a `NavigationItem`, therefore the import uses
/// `hide NavigationItem` to avoid a name collision with the local model.
class NavigationItems {
  /// Creates a navigation item provider for the given [context].
  const NavigationItems({required this.context});

  /// The context used to construct navigation callbacks (e.g. `go_router` calls).
  final BuildContext context;

  final useTopNavigation = true;

  final topNavigationBreakWidth = 900;

  /// The static navigation definition for the app.
  ///
  /// - Leaf items provide [NavigationItemModel.onPressed].
  /// - Group items provide [NavigationItemModel.children].
  List<NavigationItemModel> get items => [
    NavigationItemModel(
      index: 0,
      title: "Home",
      icon: const Icon(LucideIcons.house),
      onPressed: () => context.goNamed(RouteNames.home),
    ),
    NavigationItemModel(
      index: null,
      title: "Components",
      children: [
        NavigationItemModel(
          index: 1,
          title: "Buttons",
          icon: const Icon(LucideIcons.component),
          onPressed: () => context.goNamed(RouteNames.buttons),
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
