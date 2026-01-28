import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:police_flutter_template/screens/widgets/layouts/responsive.dart';
import 'package:police_flutter_template/settings/footer_settings.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/footer_link_model.dart';

/// Bottom section of the footer.
///
/// Displays:
/// - a row of small "utility" links (internal routes or external URLs)
/// - copyright
/// - an optional informational hint below the links (see [FooterSettings.hint])
class FooterBottomArea extends StatefulWidget {
  const FooterBottomArea({super.key});

  @override
  State<FooterBottomArea> createState() => _FooterBottomAreaState();
}

class _FooterBottomAreaState extends State<FooterBottomArea> {
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

  /// Handles navigation for a given footer link.
  ///
  /// - Uses `go_router` if [FooterLinkModel.route] is set.
  /// - Uses `url_launcher` if [FooterLinkModel.url] is set.
  void _onPressed(BuildContext context, FooterLinkModel link) async {
    if (link.route != null) {
      context.pushNamed(link.route!);
    }
    if (link.url != null) {
      final uri = Uri.parse(link.url!);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // TODO: Handle error with notification
        // throw Exception('Konnte URL nicht öffnen: $uri');
      }
    }
  }

  /// Builds the link row.
  Widget _getLinks(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: FooterSettings.copyrightLinks
        .map(
          (link) => (Button(
        style: ButtonStyle.text(density: ButtonDensity.compact)
            .withPadding(padding: EdgeInsets.zero)
            .withForegroundColor(
          color: Colors.gray[400],
          hoverColor: Colors.white,
        ),
        onPressed: () => _onPressed(context, link),
        child: Text(link.title),
      )),
    )
        .toList(),
  ).gap(20);

  /// Builds the copyright block.
  Widget _getCopyright() => Column(
    children: [
      Text(
        '© ${DateTime.now().year} Polizei Berlin',
      ).small.setColors(lightColor: Colors.white.withAlpha(220)),
      Text(
        '${_version == "0.0.0" ? '' : 'v$_version | '}Alle Rechte vorbehalten',
      ).xSmall.setColors(lightColor: Colors.gray[500]),
    ],
  ).gap(5);

  @override
  Widget build(BuildContext context) {
    final info = FooterSettings.hint(context);
    return Column(
      children: [
        Responsive.isMobile(context)
            ? Column(children: [_getLinks(context), _getCopyright()]).gap(15)
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_getLinks(context), _getCopyright()],
        ),
        if (info != null) ...[
          Gap(24),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.gray[800].withAlpha(128),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
            child: info,
          ),
        ],
      ],
    );
  }
}