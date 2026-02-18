import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Immutable data model for a single entry in [ContactList].
///
/// This model represents a "person/contact-like" row that is typically rendered
/// with:
/// - an [Avatar] on the left (visual identity)
/// - a [title] (primary label, e.g. name)
/// - a [subtitle] (secondary label, e.g. role, phone number, department)
///
/// Notes:
/// - The [Avatar] is a widget from `shadcn_flutter`, allowing callers to decide
///   whether it shows an image, initials, an icon, etc.
/// - This model intentionally contains only the display data. Actions (onTap,
///   navigation, menus) should be handled by the parent widget that renders the list.
class ContactListModel {
  /// Creates a display-only contact list item.
  const ContactListModel({
    required this.avatar,
    required this.title,
    required this.subtitle,
  });

  /// Leading visual element of the row.
  ///
  /// Usually an avatar image/initials, but can be any `shadcn_flutter` [Avatar]
  /// configuration.
  final Avatar avatar;

  /// Primary text shown for the item.
  ///
  /// Example: "Max Mustermann"
  final String title;

  /// Secondary text shown below/next to the title.
  ///
  /// Example: "Leitstelle • +49 …"
  final String subtitle;
}
