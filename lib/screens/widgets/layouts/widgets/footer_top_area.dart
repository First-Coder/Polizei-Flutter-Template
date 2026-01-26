import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../settings/footer_settings.dart';
import '../responsive.dart';
import 'footer_contact.dart';
import 'footer_links.dart';
import 'footer_logo_slogan.dart';

class FooterTopArea extends StatelessWidget {
  const FooterTopArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Column(
            children: [
              FooterLogoSlogan(),
              FooterLinks(section: FooterSettings.section1),
              FooterLinks(section: FooterSettings.section2),
              FooterContact(),
              Gap(32),
            ],
          ).gap(20)
        : LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 16.0;
              const minCardWidth = 275 - (4 * spacing);
              int maxColumns = Responsive.isDesktop(context)
                  ? 4
                  : Responsive.isTablet(context)
                  ? 2
                  : 1;

              final availableWidth = constraints.maxWidth;

              final columns =
                  ((availableWidth + spacing) / (minCardWidth + spacing))
                      .floor()
                      .clamp(1, maxColumns);

              final itemCount = Responsive.isTablet(context)
                  ? 4 -
                        (FooterSettings.section1 == null ? 1 : 0) -
                        (FooterSettings.section2 == null ? 1 : 0)
                  : 4;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  mainAxisExtent: FooterSettings
                      .heightOfFooterLinkSection, // Breite/Höhe der Cards
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return FooterLogoSlogan().withPadding(horizontal: 30);
                  } else if (index < itemCount - 1) {
                    return FooterLinks(
                      section: itemCount < 4
                          ? index == 1 && FooterSettings.section1 != null
                                ? FooterSettings.section1
                                : FooterSettings.section2
                          : index == 1
                          ? FooterSettings.section1
                          : FooterSettings.section2,
                    ).withPadding(horizontal: 30);
                  }

                  return FooterContact();
                },
              );
            },
          );
  }
}
