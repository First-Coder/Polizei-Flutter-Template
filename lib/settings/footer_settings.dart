import 'package:police_flutter_template/screens/widgets/layouts/models/footer_contact_model.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/footer_link_model.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/footer_link_section_model.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FooterSettings {
  static double heightOfFooterLinkSection = 160;

  static FooterLinkSectionModel? section1;
  static FooterLinkSectionModel? section2;

  static List<FooterLinkModel> copyrightLinks = [
    FooterLinkModel(title: "Tickets", url: "https://google.de"),
    FooterLinkModel(title: "Monitoring", url: "https://google.de"),
    FooterLinkModel(title: "Feedback", url: "https://google.de"),
    FooterLinkModel(title: "FAQ", url: "https://google.de"),
  ];

  static List<FooterContactModel> contacts = [
    FooterContactModel(
      icon: LucideIcons.phone,
      title: "Zentrale",
      label: "030 / 4664 - 0",
      value: "+493046640",
      isPhone: true,
    ),
    FooterContactModel(
      icon: LucideIcons.mail,
      title: "E-Mail",
      value: "kontakt@polizei.berlin.de",
      isMail: true,
    ),
  ];

  static Widget? hint(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 12),
        children: [
          TextSpan(
            text: 'Wichtiger Hinweis: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const TextSpan(
            text:
                'Im Notfall wählen Sie immer die 110. Diese Website dient ausschließlich Informationszwecken und ersetzt keinen Notruf.',
          ),
        ],
      ),
      textAlign: TextAlign.center,
      softWrap: true,
    );
  }
}
