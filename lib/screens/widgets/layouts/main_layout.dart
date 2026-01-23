import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/extensions/button_extensions.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:police_flutter_template/screens/widgets/light_button.dart';
import 'package:police_flutter_template/settings/app_constants.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../theme/cubit/theme_cubit.dart';

/// Main shell layout for authenticated areas.
///
/// Wraps a [StatefulNavigationShell] and provides a persistent header bar.
/// The actual route content is rendered via [navigationShell].
class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.navigationShell});

  /// The go_router navigation shell (e.g. for bottom tabs / branches).
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    /// Index of the current navigation item.
    ///
    /// Note: This is currently unused; consider wiring it to navigationShell
    /// state when you implement multi-branch navigation.
    int index = 0;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = (state as Authorized).user;
        return Scaffold(
          loadingProgressIndeterminate: false,
          headers: [
            Container(
              color: isDarkMode ? Colors.gray[900] : Colors.white,
              child: Container(
                constraints: BoxConstraints(maxWidth: 1280),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand section: logo + title.
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/logo/polizeistern.svg',
                            height: 40,
                            semanticsLabel: 'Berliner Polizei Logo',
                          ),
                        ),
                        Gap(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppConstants.projectTitle).bold
                                .setColors(
                                  lightColor: Colors.blue[900],
                                  darkColor: Colors.blue[700],
                                )
                                .responsive(
                                  context,
                                  mobile: (t) => t.small,
                                  tablet: (t) => t.base,
                                  desktop: (t) => t.xLarge,
                                ),
                            Text(AppConstants.organization).small.setColors(
                              lightColor: Colors.gray[600],
                              darkColor: Colors.gray[400],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Primary navigation (popover menus, etc.).
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LightButton(
                          onPressed: () {},
                          isIcon: false,
                          trailing: const Icon(LucideIcons.chevronDown),
                          child: const Text('Aktuelles'),
                        ).withPopover(
                          enablePress: false,
                          enableHover: true,
                          offset: const Offset(0, -4),
                          builder: (context) {
                            return ModalContainer(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LightButton(
                                    leading: const Icon(LucideIcons.newspaper),
                                    borderRadius: 0,
                                    isIcon: false,
                                    onPressed: () {},
                                    child: Text('Online-Anzeige'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    // User actions (theme toggle, search, profile menu).
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LightButton(
                          onPressed: () {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                          isIcon: true,
                          child: isDarkMode
                              ? const Icon(LucideIcons.sun, size: 20)
                              : const Icon(LucideIcons.moon, size: 20),
                        ),
                        Button(
                          style: ButtonStyle.ghostIcon().withBackgroundColor(
                            hoverColor: isDarkMode
                                ? Colors.gray[800]
                                : Colors.blue[50],
                          ),
                          // density: ButtonDensity.icon,
                          onPressed: () {},
                          child: const Icon(LucideIcons.search, size: 20),
                        ),
                        Button(
                          style: ButtonStyle.card()
                              .copyWith(
                                decoration: (context, states, value) {
                                  return BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  );
                                },
                              )
                              .withBackgroundColor(
                                hoverColor: isDarkMode
                                    ? Colors.gray[800]
                                    : Colors.blue[50],
                              ),
                          onPressed: () {},
                          trailing: const Icon(LucideIcons.chevronDown),
                          child: Basic(
                            title: Text('${user.firstName} ${user.lastName}'),
                            subtitle: Text('Pers. Nr.: ${user.id}'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).withPadding(all: 10),
              ).center(),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: SizedBox(
                height: 1,
                width: double.infinity,
                child: ColoredBox(
                  // Divider color depending on the theme.
                  color: isDarkMode ? Colors.gray[700] : Colors.gray[200],
                ),
              ),
            ),
          ],
          child: navigationShell,
        );
      },
    );
  }
}
