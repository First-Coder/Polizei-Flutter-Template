import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/widgets/layouts/widgets/sidebar_header.dart';
import 'package:police_flutter_template/screens/widgets/light_button.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide NavigationItem;
import 'package:url_launcher/url_launcher.dart';

import '../../../../features/toast_exceptions.dart';
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

  void _onPressed(BuildContext context, NavigationItemModel item) async {
    if (item.onPressed != null) {
      item.onPressed!();
      return;
    }
    if (!item.isExternal || item.url == null) {
      return;
    }
    final url = item.url!;
    final uri = Uri.parse(url);
    final launch = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launch) {
      if (!context.mounted) {
        return;
      }
      showToast(
        context: context,
        builder: (toastContext, overlay) {
          return toastExceptionLaunchUrl(toastContext, overlay, url);
        },
      );
    }
  }

  List<NavigationBarItem> _getNavigationItems(
    BuildContext context,
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
              onPressed: () => _onPressed(context, subItem),
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
            onPressed: () => _onPressed(context, item),
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
                  context,
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
                onPressed: () => {_onPressed(context, item)},
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
