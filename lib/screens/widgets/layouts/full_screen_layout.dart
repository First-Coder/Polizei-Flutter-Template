import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../extensions/text_extensions.dart';
import '../../../settings/app_constants.dart';
import 'multi_provider_layout.dart';

class FullScreenLayout extends StatefulWidget {
  const FullScreenLayout({super.key, required this.children, this.decoration});

  final List<Widget> children;

  final Decoration? decoration;

  @override
  State<FullScreenLayout> createState() => _FullScreenLayoutState();
}

class _FullScreenLayoutState extends State<FullScreenLayout> {
  /// App version shown in the footer (loaded asynchronously).
  String _version = '0.0.0';

  @override
  void initState() {
    super.initState();

    // Load app metadata such as version/build number for display.
    _loadAppInfo();
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
    return MultiProviderLayout(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: widget.decoration,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.minHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(32),
                          // Header with logo
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/logo/polizeistern.svg',
                                height: 60,
                                semanticsLabel: 'Berliner Polizei Logo',
                              ),
                              Gap(15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppConstants.projectTitle,
                                  ).bold.x3Large.setColors(
                                    lightColor: Colors.blue[900],
                                    darkColor: Colors.blue[700],
                                  ),
                                  Text(
                                    AppConstants.organization,
                                  ).setColors(
                                    lightColor: Colors.gray[600],
                                    darkColor: Colors.gray[400],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Gap(42),
                          // Content
                          ...widget.children,
                          // Footer info
                          Gap(24),
                          Text(
                            '${_version == "0.0.0" ? '' : 'v$_version '}© ${DateTime.now().year} Polizei Berlin | Alle Rechte vorbehalten',
                          ).xSmall.setColors(
                            lightColor: Colors.gray[500],
                            darkColor: Colors.gray[400],
                          ),
                          Gap(32),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
