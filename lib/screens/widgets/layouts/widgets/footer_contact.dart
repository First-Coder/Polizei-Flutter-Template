import 'package:police_flutter_template/screens/widgets/layouts/models/footer_contact_model.dart';
import 'package:police_flutter_template/settings/footer_settings.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../extensions/text_extensions.dart';
import '../responsive.dart';

/// Renders the "Contact" area in the footer.
///
/// The displayed contacts are defined in [FooterSettings.contacts].
class FooterContact extends StatelessWidget {
  const FooterContact({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text("Kontakt").h4.semiBold.setColors(lightColor: Colors.white),
        ...FooterSettings.contacts.map(
          (contact) => (_FooterContactRow(model: contact)),
        ),
      ],
    ).gap(12);
  }
}

/// Single row entry for a footer contact.
///
/// Supports:
/// - click-to-call if [FooterContactModel.isPhone] is true
/// - click-to-email if [FooterContactModel.isMail] is true
class _FooterContactRow extends StatelessWidget {
  const _FooterContactRow({required this.model});

  /// Contact model definition for this row.
  final FooterContactModel model;

  /// Launches a phone or mail intent depending on the model flags.
  Future<void> _call() async {
    if (!model.isMail && !model.isPhone) return;
    final uri = Uri(scheme: model.isMail ? 'mailto' : 'tel', path: model.value);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // TODO: Exception if needed (Snackbar/Toast/Log)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Icon(model.icon, color: Colors.blue[500], size: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                ).small.semiBold.setColors(lightColor: Colors.white),
                Button(
                  style: ButtonStyle.text(density: ButtonDensity.compact)
                      .withPadding(padding: EdgeInsets.zero)
                      .withForegroundColor(
                        color: Colors.gray[400],
                        hoverColor: Colors.white,
                      ),
                  onPressed: () => _call(),
                  child: Text(model.label ?? model.value),
                ),
              ],
            ).gap(5),
          ],
        )
        .gap(10)
        .withPadding(
          horizontal: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width * 0.1
              : 0,
        );
  }
}
