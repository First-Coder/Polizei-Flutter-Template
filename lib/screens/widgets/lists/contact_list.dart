import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'models/contact_list_model.dart';

/// Renders a simple vertical list of "contact-like" items using `shadcn_flutter`'s [Basic].
///
/// Each entry uses:
/// - `leading`: [ContactListModel.avatar]
/// - `title`: [ContactListModel.title]
/// - `subtitle`: [ContactListModel.subtitle]
///
/// Layout:
/// - Implemented as a [Column] with `crossAxisAlignment: CrossAxisAlignment.start`.
/// - Adds vertical spacing between rows via `.gap(10)`.
///
/// When to use:
/// - Small lists that fit on screen (settings-like pages, small directories).
///
/// When *not* to use:
/// - Large/scrolling lists: prefer `ListView.builder` (better performance and scrolling).
///
/// Interactions:
/// - This widget is display-only. If you need taps, context menus, trailing actions, etc.,
///   wrap/extend the [Basic] widget in the `.map(...)` section.
class ContactList extends StatelessWidget {
  const ContactList({super.key, required this.items});

  /// Items to be rendered as rows.
  final List<ContactListModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => (Basic(
              leading: item.avatar,
              title: Text(item.title),
              subtitle: Text(item.subtitle),
            )),
          )
          .toList(),
    ).gap(10);
  }
}
