import 'package:shadcn_flutter/shadcn_flutter.dart';

class FooterContactModel {
  FooterContactModel({
    required this.icon,
    required this.title,
    this.label,
    required this.value,
    this.isPhone = false,
    this.isMail = false,
  });

  final IconData icon;
  final String title;
  final String? label;
  final String value;
  final bool isPhone;
  final bool isMail;
}
