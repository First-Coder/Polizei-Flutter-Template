import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:police_flutter_template/screens/widgets/layouts/responsive.dart';
import 'package:police_flutter_template/settings/footer_settings.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/footer_link_model.dart';

class FooterBottomArea extends StatelessWidget {
  const FooterBottomArea({super.key});

  void _onPressed(BuildContext context, FooterLinkModel link) async {
    if (link.route != null) {
      context.goNamed(link.route!);
    }
    if (link.url != null) {
      final uri = Uri.parse(link.url!);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // TODO: Handle error with notification
        // throw Exception('Konnte URL nicht öffnen: $uri');
      }
    }
  }

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

  Widget _getCopyright() => Column(
    children: [
      Text(
        '© ${DateTime.now().year} Polizei Berlin',
      ).small.setColors(lightColor: Colors.white.withAlpha(220)),
      Text(
        'Alle Rechte vorbehalten',
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
