import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../extensions/widget_extensions.dart';
import '../../../theme/cubit/theme_cubit.dart';

/// The landing page hero section shown on the home screen.
///
/// Responsibilities:
/// - Displays app version (loaded via `package_info_plus`)
/// - Shows a headline, short description, and primary actions
/// - Renders a responsive grid of feature cards
///
/// Theme behavior:
/// - Uses [ThemeCubit] to adjust colors and gradients for dark/light mode.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.installationKey});

  final GlobalKey installationKey;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  /// App version shown in the footer (loaded asynchronously).
  String _version = '0.0.0';

  /// Static list of feature cards displayed in the hero grid.
  final List<_HeroCards> _heroCards = const [
    _HeroCards(
      icon: LucideIcons.palette,
      title: "Polizei-Blau Design System",
      text:
          "Professionelles Farbschema mit Berlin Polizei Blau als Primärfarbe",
    ),
    _HeroCards(
      icon: LucideIcons.moon,
      title: "Light & Dark Mode",
      text: "Vollständige Theme-Unterstützung mit automatischem Wechsel",
    ),
    _HeroCards(
      icon: LucideIcons.phone,
      title: "Vollständig Responsive",
      text: "Mobile-First Design optimiert für alle Bildschirmgrößen",
    ),
    _HeroCards(
      icon: LucideIcons.shield,
      title: "Sicherheit & Vertrauen",
      text: "Designt für behördliche und professionelle Anwendungen",
    ),
    _HeroCards(
      icon: LucideIcons.layoutDashboard,
      title: "Umfangreiche UI-Bibliothek",
      text: "84+ wiederverwendbare React-Komponenten",
    ),
    _HeroCards(
      icon: LucideIcons.bolt,
      title: "Performance-Optimiert",
      text: "In Flutter für native integration optimiert",
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Load app metadata such as version/build number for display.
    _loadAppInfo();
  }

  Future<void> _scrollToInstallation() async {
    final ctx = widget.installationKey.currentContext;
    if (ctx == null) return;

    await Scrollable.ensureVisible(
      ctx,
      alignment: 0.0, // 0.0 = oben im Viewport
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  /// Loads app information (e.g. version) from the underlying platform.
  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return Container(
      decoration: isDarkMode
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.gray[950], Colors.blue[950], Colors.gray[900]],
              ),
            )
          : BoxDecoration(color: Colors.gray[50]),
      width: double.infinity,
      child: Column(
        children: [
          Gap(64),
          PrimaryBadge(child: Text('Flutter Template v.$_version')),
          Gap(5),
          Text('Polizei Berlin').x5Large.h1.setColors(
            lightColor: Colors.gray[800],
            darkColor: Colors.white,
          ),
          Text('Design Template').x5Large.h1.setColors(
            lightColor: Colors.blue[800],
            darkColor: Colors.blue[400],
          ),
          Gap(20),
          Container(
            constraints: BoxConstraints(maxWidth: 500),
            child: Text(
              'Ein modernes, professionelles und vollständig responsives Web/iOS/Android/macOs/Windows-Template für behördliche Anwendungen. Entwickelt mit Flutter und shadcn_flutter.',
              textAlign: TextAlign.center,
            ).muted,
          ),
          Gap(30),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                leading: const Icon(LucideIcons.download),
                onPressed: _scrollToInstallation,
                child: const Text('Installation starten'),
              ),
              Button(
                style: const ButtonStyle.outline().withBackgroundColor(
                  color: isDarkMode ? Colors.gray[800] : Colors.white,
                  hoverColor: isDarkMode ? Colors.gray[700] : Colors.gray[100],
                ),
                leading: const Icon(LucideIcons.eye),
                onPressed: () async {
                  final uri = Uri.parse("https://sunarya-thito.github.io/shadcn_flutter/");
                  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                  // TODO: Handle error with notification
                  // throw Exception('Konnte URL nicht öffnen: $uri');
                  }
                },
                child: const Text('Komponenten ansehen'),
              ),
            ],
          ).gap(10),
          Gap(50),
          Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 16.0;
                const minCardWidth = 304.0;
                const maxColumns = 3;

                final availableWidth = constraints.maxWidth;

                final columns =
                    ((availableWidth + spacing) / (minCardWidth + spacing))
                        .floor()
                        .clamp(1, maxColumns);

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _heroCards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    mainAxisExtent: 230, // Breite/Höhe der Cards
                  ),
                  itemBuilder: (context, index) {
                    final card = _heroCards[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.blue[700]
                                    : Colors.blue[900],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                card.icon,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(20),
                            Text(card.title).h4,
                            const Gap(6),
                            Flexible(
                              child: Text(
                                card.text,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ).muted,
                            ),
                          ],
                        ),
                      ),
                    ).withHoverEffect(
                      borderColor: isDarkMode
                          ? Colors.gray[600]
                          : Colors.gray[300],
                      hoverBorderColor: isDarkMode
                          ? Colors.blue[700]
                          : Colors.blue[900],
                      borderWidth: 1.5,
                    );
                  },
                );
              },
            ),
          ),
          Gap(64),
        ],
      ),
    );
  }
}

/// Immutable data object used to render a single hero feature card.
class _HeroCards {
  const _HeroCards({
    required this.icon,
    required this.title,
    required this.text,
  });

  /// Feature icon.
  final IconData icon;

  /// Feature title.
  final String title;

  /// Short feature description.
  final String text;
}
