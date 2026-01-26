class FooterLinkModel {
  const FooterLinkModel({
    required this.title,
    this.url,
    this.route,
  });
  final String title;
  final String? url;
  final String? route;
}