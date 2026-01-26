import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/footer_link_model.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/footer_link_section_model.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../extensions/text_extensions.dart';
import '../responsive.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key, required this.section});

  final FooterLinkSectionModel? section;

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

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    if (section == null) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(section!.title).h4.semiBold.setColors(lightColor: Colors.white),
        ...section!.links.map(
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
        ),
      ],
    ).gap(12);
  }
}
