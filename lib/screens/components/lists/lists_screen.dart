import 'package:police_flutter_template/extensions/widget_extensions.dart';
import 'package:police_flutter_template/screens/widgets/lists/contact_list.dart';
import 'package:police_flutter_template/screens/widgets/lists/icon_list.dart';
import 'package:police_flutter_template/screens/widgets/lists/models/contact_list_model.dart';
import 'package:police_flutter_template/screens/widgets/lists/models/icon_list_model.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widgets/code_card.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 752),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Listen verwenden').h3,
          CodeCard(
            title: "Einfache Liste",
            example: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Online-Anzeige erstatten'),
                  const Text('Fundstelle melden'),
                  const Text('Präventionstipps lesen'),
                  const Text('Termine vereinbaren'),
                ],
              ).liIcon(icon: LucideIcons.check, color: Colors.green[600]),
            ),
            lines: [
              CodeTextLine("Column("),
              CodeTextLine("  crossAxisAlignment: CrossAxisAlignment.start,"),
              CodeTextLine("  children: const ["),
              CodeTextLine("    Text('Online-Anzeige erstatten'),"),
              CodeTextLine("    Text('Fundstelle melden'),"),
              CodeTextLine("    Text('Präventionstipps lesen'),"),
              CodeTextLine("    Text('Termine vereinbaren'),"),
              CodeTextLine("  ],"),
              CodeTextLine(
                ").liIcon(icon: LucideIcons.check, color: Colors.green[600]),",
              ),
            ],
          ),
          CodeCard(
            title: "Liste mit Icons",
            example: SizedBox(
              width: double.infinity,
              child: IconList(
                items: [
                  IconListModel(
                    icon: LucideIcons.phone,
                    title: "Notruf",
                    subtitle: "24/7 erreichbar unter 110",
                  ),
                  IconListModel(
                    icon: LucideIcons.mail,
                    title: "E-Mail",
                    subtitle: "kontakt@polizei.berlin.de",
                  ),
                  IconListModel(
                    icon: LucideIcons.pin,
                    title: "Standorte",
                    subtitle: "Über 100 Wachen in Berlin",
                  ),
                ],
              ),
            ),
            lines: [
              CodeTextLine("IconList(items: ["),
              CodeTextLine("  IconListModel("),
              CodeTextLine("    icon: LucideIcons.phone,"),
              CodeTextLine(
                "    title: 'Notruf',"
                " subtitle: '24/7 erreichbar unter 110',",
              ),
              CodeTextLine("  ),"),
              CodeTextLine("  IconListModel("),
              CodeTextLine("    icon: LucideIcons.mail,"),
              CodeTextLine(
                "    title: 'E-Mail',"
                " subtitle: 'kontakt@polizei.berlin.de',",
              ),
              CodeTextLine("  ),"),
              CodeTextLine("  IconListModel("),
              CodeTextLine("    icon: LucideIcons.pin,"),
              CodeTextLine(
                "    title: 'Standorte',"
                " subtitle: 'Über 100 Wachen in Berlin',",
              ),
              CodeTextLine("  ),"),
              CodeTextLine("]),"),
            ],
          ),
          CodeCard(
            title: "Kontakt-Liste",
            example: SizedBox(
              width: double.infinity,
              child: ContactList(
                items: [
                  ContactListModel(
                    avatar: Avatar(
                      initials: Avatar.getInitials('Maria Schmidt'),
                    ),
                    title: 'Maria Schmidt',
                    subtitle: 'Polizeioberkommissarin • PN-2024-1234',
                  ),
                  ContactListModel(
                    avatar: Avatar(
                      initials: Avatar.getInitials('Thomas Müller'),
                    ),
                    title: 'Thomas Müller',
                    subtitle: 'Polizeihauptkommissar • PN-2024-5678',
                  ),
                  ContactListModel(
                    avatar: Avatar(initials: Avatar.getInitials('Lisa Weber')),
                    title: 'Lisa Weber',
                    subtitle: 'Polizeikommissarin • PN-2024-9012',
                  ),
                ],
              ),
            ),
            lines: [
              CodeTextLine("ContactList(items: ["),
              CodeTextLine("  ContactListModel("),
              CodeTextLine("    avatar: Avatar("),
              CodeTextLine(
                "      initials: Avatar.getInitials('Maria Schmidt'),",
              ),
              CodeTextLine("    ),"),
              CodeTextLine("    title: 'Maria Schmidt',"),
              CodeTextLine(
                "    subtitle: 'Polizeioberkommissarin • PN-2024-1234',",
              ),
              CodeTextLine("  ),"),
              CodeTextLine("  ContactListModel("),
              CodeTextLine("    avatar: Avatar("),
              CodeTextLine(
                "      initials: Avatar.getInitials('Thomas Müller'),",
              ),
              CodeTextLine("    ),"),
              CodeTextLine("    title: 'Thomas Müller',"),
              CodeTextLine(
                "    subtitle: 'Polizeihauptkommissar • PN-2024-5678',",
              ),
              CodeTextLine("  ),"),
              CodeTextLine("  ContactListModel("),
              CodeTextLine("    avatar: Avatar("),
              CodeTextLine("      initials: Avatar.getInitials('Lisa Weber'),"),
              CodeTextLine("    ),"),
              CodeTextLine("    title: 'Lisa Weber',"),
              CodeTextLine(
                "    subtitle: 'Polizeikommissarin • PN-2024-9012',",
              ),
              CodeTextLine("  ),"),
              CodeTextLine("]),"),
            ],
          ),
        ],
      ).gap(15).withPadding(vertical: 30),
    ).withPadding(horizontal: 20);
  }
}
