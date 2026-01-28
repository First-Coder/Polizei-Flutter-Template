import 'package:go_router/go_router.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/footer_link_model.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/footer_link_section_model.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../extensions/text_extensions.dart';
import '../responsive.dart';

/// Renders a footer link section (title + list of clickable links).
///
/// Behavior:
/// - If [FooterLinkModel.route] is set, the link is treated as an internal route
///   and navigated via `go_router` (`context.pushNamed(...)`).
/// - If [FooterLinkModel.url] is set, the link is treated as an external URL and
///   opened via `url_launcher`.
///
/// If [section] is `null`, this widget renders nothing.
class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key, required this.section});

  /// Section definition to render. If null, the widget returns `SizedBox.shrink()`.
  final FooterLinkSectionModel? section;

  /// Handles internal routing and external URL launching for a given link.
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