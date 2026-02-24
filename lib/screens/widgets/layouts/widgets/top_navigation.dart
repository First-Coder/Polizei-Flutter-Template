import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/settings/navigation_items.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide NavigationItem;
import 'package:url_launcher/url_launcher.dart';

import '../../../../extensions/button_extensions.dart';
import '../../../../features/toast_exceptions.dart';
import '../../light_button.dart';
import '../models/navigation_item_model.dart';

class TopNavigation extends StatelessWidget {
  const TopNavigation({
    super.key,
    required this.navigationItems,
    required this.navigationShell,
  });

  final NavigationItems navigationItems;

  final StatefulNavigationShell navigationShell;

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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: navigationItems.items
          .map(
            (item) =>
                (LightButton(
                  onPressed: () => _onPressed(context, item),
                  isActive: item.index == navigationShell.currentIndex,
                  isIcon: false,
                  trailing: item.children.isEmpty
                      ? null
                      : const Icon(LucideIcons.chevronDown),
                  child: Row(
                    children: [
                      Text(item.title),
                      if (item.isExternal)
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const SizedBox(width: 10, height: 20),
                            Positioned(
                              top: -4,
                              right: -4,
                              child: const Icon(
                                LucideIcons.externalLink,
                                size: 10,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ).withPopover(
                  enabled: item.children.isNotEmpty,
                  enablePress: true,
                  offset: const Offset(0, -4),
                  builder: (context) {
                    return ModalContainer(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownMenu(
                        children: item.children
                            .map(
                              (subItem) => MenuButton(
                                onPressed: (context) {
                                  _onPressed(context, subItem);
                                },
                                enabled: subItem.index !=
                                    navigationShell.currentIndex,
                                leading:
                                    subItem.index ==
                                        navigationShell.currentIndex
                                    ? IconTheme(
                                        data: IconThemeData(
                                          color: Colors.gray[400],
                                          size: 16,
                                        ),
                                        child: subItem.icon!,
                                      )
                                    : subItem.icon,
                                trailing:
                                    subItem.index ==
                                        navigationShell.currentIndex
                                    ? Icon(
                                        LucideIcons.mapPin,
                                        color: Colors.gray[400],
                                      )
                                    : null,
                                child: Text(
                                  subItem.title,
                                  style:
                                      subItem.index ==
                                          navigationShell.currentIndex
                                      ? TextStyle(color: Colors.gray[400])
                                      : null,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ).intrinsicWidth();
                  },
                )),
          )
          .toList(),
    ).gap(10);
  }
}
