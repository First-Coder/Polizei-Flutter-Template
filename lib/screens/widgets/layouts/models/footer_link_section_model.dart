import 'footer_link_model.dart';

/// Groups multiple [FooterLinkModel] items under a section header in the footer.
///
/// Example:
/// - title: "Resources"
/// - links: ["FAQ", "Support", "Status"]
class FooterLinkSectionModel {
  /// Creates a footer link section.
  FooterLinkSectionModel({required this.title, required this.links});

  /// Section title displayed above the links.
  String title;

  /// Links contained in this section.
  List<FooterLinkModel> links;
}