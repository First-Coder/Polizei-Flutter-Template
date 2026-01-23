import 'package:police_flutter_template/screens/home/widgets/hero_section.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.max, children: [HeroSection()]));
  }
}
