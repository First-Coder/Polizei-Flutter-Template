import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:police_flutter_template/screens/widgets/layouts/multi_provider_layout.dart';
import 'package:police_flutter_template/screens/widgets/layouts/widgets/footer_bottom_area.dart';
import 'package:police_flutter_template/screens/widgets/layouts/widgets/footer_top_area.dart';
import 'package:police_flutter_template/screens/widgets/layouts/widgets/sidebar_navigation.dart';
import 'package:police_flutter_template/screens/widgets/layouts/widgets/top_navigation.dart';
import 'package:police_flutter_template/screens/widgets/light_button.dart';
import 'package:police_flutter_template/settings/app_constants.dart';
import 'package:police_flutter_template/settings/navigation_items.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../settings/search_engine.dart';
import '../../../theme/cubit/theme_cubit.dart';

/// Main shell layout for authenticated areas.
///
/// Wraps a [StatefulNavigationShell] and provides a persistent header bar.
/// The actual route content is rendered via [navigationShell].
class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.navigationShell});

  /// The go_router navigation shell (e.g. for bottom tabs / branches).
  final StatefulNavigationShell navigationShell;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool showSearch = false;

  final searchEngine = SearchEngine();

  @override
  Widget build(BuildContext context) {
    final navigationItems = NavigationItems(context: context);

    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < navigationItems.topNavigationBreakWidth;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = (state as Authorized).user;
        return MultiProviderLayout(
          child: Scaffold(
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
                          SvgPicture.asset(
                            'assets/logo/polizeistern.svg',
                            height: 50,
                            semanticsLabel: 'Berliner Polizei Logo',
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

                      // Primary navigation for desktop.
                      if (!isMobile) ...[
                        TopNavigation(
                          navigationItems: navigationItems,
                          navigationShell: widget.navigationShell,
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
                            if (searchEngine.showSearch)
                              LightButton(
                                onPressed: () {
                                  setState(() {
                                    showSearch = !showSearch;
                                  });
                                },
                                isIcon: true,
                                child: showSearch
                                    ? const Icon(LucideIcons.x, size: 20)
                                    : const Icon(LucideIcons.search, size: 20),
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
                                title: Text(
                                  '${user.firstName} ${user.lastName}',
                                ),
                                subtitle: Text('Pers. Nr.: ${user.id}'),
                              ),
                            ),
                          ],
                        ),
                      ],

                      if (isMobile)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LightButton(
                              onPressed: () {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                              isIcon: true,
                              child: isDarkMode
                                  ? const Icon(LucideIcons.sun, size: 22)
                                  : const Icon(LucideIcons.moon, size: 22),
                            ),
                            if (searchEngine.showSearch)
                              LightButton(
                                onPressed: () {
                                  setState(() {
                                    showSearch = !showSearch;
                                  });
                                },
                                isIcon: true,
                                child: showSearch
                                    ? const Icon(LucideIcons.x, size: 22)
                                    : const Icon(LucideIcons.search, size: 22),
                              ),
                            LightButton(
                              onPressed: () {
                                openSheet(
                                  context: context,
                                  barrierColor: Colors.black.withAlpha(100),
                                  builder: (sidebarContext) =>
                                      SidebarNavigation(
                                        sidebarContext: sidebarContext,
                                        navigationItems: navigationItems,
                                        navigationShell: widget.navigationShell,
                                      ),
                                  position: OverlayPosition.left,
                                );
                              },
                              isIcon: true,
                              child: const Icon(LucideIcons.menu, size: 22),
                            ),
                          ],
                        ).gap(10),
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
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Content
                      widget.navigationShell,
                      // Footer
                      SizedBox(
                        width: double.infinity,
                        child: ColoredBox(
                          color: Colors.gray[900],
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 1280),
                              child: Column(
                                children: [
                                  Gap(48),
                                  FooterTopArea(),
                                  Divider(
                                    color: Colors.gray[700],
                                  ).withPadding(vertical: 25),
                                  FooterBottomArea(),
                                  Gap(48),
                                ],
                              ),
                            ).withPadding(horizontal: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (showSearch) ...[
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() => showSearch = false);
                      },
                      child: Container(color: Colors.black.withAlpha(100)),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // Klicks im Command schließen NICHT (Event wird hier abgefangen)
                      },
                      child: Command(
                        builder: searchEngine.queryBuilder,
                        searchPlaceholder: searchEngine.searchPlaceholder,
                        loadingBuilder: searchEngine.loadingBuilder,
                        emptyBuilder: searchEngine.emptyBuilder,
                      ).sized(width: 600, height: 400),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
