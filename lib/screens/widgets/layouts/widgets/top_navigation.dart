import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/settings/navigation_items.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../extensions/button_extensions.dart';
import '../../light_button.dart';

class TopNavigation extends StatelessWidget {
  const TopNavigation({
    super.key,
    required this.navigationItems,
    required this.navigationShell,
  });

  final NavigationItems navigationItems;

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: navigationItems.items
          .map(
            (item) =>
                (LightButton(
                  onPressed:
                      item.onPressed ??
                      () async {
                        if (!item.isExternal || item.url == null) return;
                        final uri = Uri.parse(item.url!);
                        if (!await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        )) {
                          // TODO: Handle error with notification
                          // throw Exception('Konnte URL nicht öffnen: $uri');
                        }
                      },
                  isActive: item.index == navigationShell.currentIndex,
                  isIcon: false,
                  leading: item.icon,
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
                  enablePress: false,
                  enableHover: true,
                  offset: const Offset(0, -4),
                  builder: (context) {
                    return ModalContainer(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: item.children
                            .map(
                              (subItem) => (LightButton(
                                onPressed: subItem.onPressed ?? () {},
                                isIcon: false,
                                isActive:
                                    subItem.index ==
                                    navigationShell.currentIndex,
                                borderRadius: 0,
                                leading: subItem.icon,
                                child: Text(subItem.title),
                              )),
                            )
                            .toList(),
                      ),
                    );
                  },
                )),
          )
          .toList(),
    ).gap(10);
  }
}
