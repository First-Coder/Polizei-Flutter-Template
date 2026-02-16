import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/widgets/layouts/widgets/sidebar_header.dart';
import 'package:police_flutter_template/screens/widgets/light_button.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide NavigationItem;
import 'package:url_launcher/url_launcher.dart';

import '../models/navigation_item_model.dart';
import '../../../../settings/navigation_items.dart';
import '../../../../theme/cubit/theme_cubit.dart';

class SidebarNavigation extends StatelessWidget {
  const SidebarNavigation({
    super.key,
    required this.sidebarContext,
    required this.navigationItems,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  final BuildContext sidebarContext;

  final NavigationItems navigationItems;

  void _onPressed(NavigationItemModel item) async {
    if (item.onPressed != null) {
      item.onPressed!();
      return;
    }
    if (!item.isExternal || item.url == null) return;
    final uri = Uri.parse(item.url!);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // TODO: Handle error with notification
      // throw Exception('Konnte URL nicht öffnen: $uri');
    }
  }

  List<NavigationBarItem> _getNavigationItems(
    bool isDarkMode,
    Color activeBackgroundColor,
  ) {
    final items = <NavigationBarItem>[];
    for (final item in navigationItems.items) {
      if (item.children.isNotEmpty) {
        items.addAll([
          NavigationLabel(
            padding: EdgeInsets.zero,
            child: Text(item.title).small,
          ),
        ]);
        for (final subItem in item.children) {
          items.add(
            NavigationButton(
              onPressed: () => _onPressed(subItem),
              style: lightButtonStyle(
                isDarkMode: isDarkMode,
                isActive: subItem.index == navigationShell.currentIndex,
                activeBackgroundColor: activeBackgroundColor,
              ),
              label: Text(subItem.title).small,
              child: subItem.icon ?? const Icon(LucideIcons.anchor),
            ),
          );
        }
        items.add(
          NavigationDivider(
            color: isDarkMode ? Colors.gray[700] : Colors.gray[200],
          ),
        );
      } else {
        items.add(
          NavigationButton(
            onPressed: () => _onPressed(item),
            style: lightButtonStyle(
              isDarkMode: isDarkMode,
              isActive: item.index == navigationShell.currentIndex,
              activeBackgroundColor: activeBackgroundColor,
            ),
            label: Text(item.title).small,
            child: item.icon ?? const Icon(LucideIcons.anchor),
          ),
        );
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    final activeBackgroundColor = isDarkMode
        ? Colors.gray[900]
        : Colors.blue[100];
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      decoration: BoxDecoration(border: null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarHeader(sidebarContext: sidebarContext),
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: NavigationSidebar(
                children: _getNavigationItems(
                  isDarkMode,
                  activeBackgroundColor,
                ),
              ),
            ),
          ).withPadding(all: 16).expanded(),
          Divider(
            color: isDarkMode ? Colors.gray[700] : Colors.gray[200],
          ).withPadding(horizontal: 16, top: 24, bottom: 12),
          ...navigationItems.profileItems.map(
            (item) => (SizedBox(
              width: double.infinity,
              child: TextButton(
                alignment: Alignment.centerLeft,
                onPressed: () => {_onPressed(item)},
                child: Text(item.title).normal,
              ),
            )),
          ),
          Gap(10),
        ],
      ),
    );
  }
}
