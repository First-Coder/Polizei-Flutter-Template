import 'package:flutter_svg/svg.dart';
import 'package:police_flutter_template/screens/widgets/layouts/responsive.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../extensions/text_extensions.dart';
import '../../../../settings/app_constants.dart';

class FooterLogoSlogan extends StatelessWidget {
  const FooterLogoSlogan({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo/polizeistern.svg',
              height: 50,
              semanticsLabel: 'Berliner Polizei Logo',
            ),
            Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.organization,
                ).h4.bold.setColors(lightColor: Colors.white),
                Text(
                  AppConstants.footerSlogan,
                ).small.setColors(lightColor: Colors.gray[400]),
              ],
            ),
          ],
        ),
        Gap(16),
        SizedBox(
          width: isMobile ? MediaQuery.of(context).size.width * 0.6 : null,
          child: Text(
            AppConstants.footerInfoText,
            textAlign: isMobile ? TextAlign.center : null,
            softWrap: true,
          ).small.setColors(lightColor: Colors.gray[400]),
        ),
      ],
    );
  }
}
