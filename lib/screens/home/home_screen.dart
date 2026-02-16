import 'package:police_flutter_template/screens/home/widgets/additional_resources.dart';
import 'package:police_flutter_template/screens/home/widgets/hero_section.dart';
import 'package:police_flutter_template/screens/home/widgets/installation.dart';
import 'package:police_flutter_template/screens/home/widgets/technology_stack.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final installationKey = GlobalKey();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        HeroSection(installationKey: installationKey),
        Installation(key: installationKey),
        TechnologyStack(),
        AdditionalResources(),
      ],
    );
  }
}
