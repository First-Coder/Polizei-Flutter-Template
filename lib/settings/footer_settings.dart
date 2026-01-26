import 'package:police_flutter_template/screens/widgets/layouts/models/footer_contact_model.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/footer_link_model.dart';
import 'package:police_flutter_template/screens/widgets/layouts/models/footer_link_section_model.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Central configuration for the application's footer.
///
/// This class contains:
/// - layout constants (e.g. [heightOfFooterLinkSection])
/// - optional footer link sections ([section1], [section2])
/// - the list of copyright links
/// - the list of contact entries
/// - an optional informational hint widget ([hint])
///
/// Note:
/// This is a simple static configuration holder. If you need runtime updates,
/// localization, or remote config, consider injecting a service instead.
class FooterSettings {
  /// Fixed height used by the grid layout for link sections.
  static double heightOfFooterLinkSection = 160;

  /// Optional first link section shown in the footer.
  static FooterLinkSectionModel? section1;

  /// Optional second link section shown in the footer.
  static FooterLinkSectionModel? section2;

  /// Links displayed in the bottom footer area (e.g. legal/help/status).
  static List<FooterLinkModel> copyrightLinks = [
    FooterLinkModel(title: "Tickets", url: "https://google.de"),
    FooterLinkModel(title: "Monitoring", url: "https://google.de"),
    FooterLinkModel(title: "Feedback", url: "https://google.de"),
    FooterLinkModel(title: "FAQ", url: "https://google.de"),
  ];

  /// Contact entries displayed in the footer (phone, mail, etc.).
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

  /// Optional informational hint shown below the footer.
  ///
  /// Return `null` to hide the hint.
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