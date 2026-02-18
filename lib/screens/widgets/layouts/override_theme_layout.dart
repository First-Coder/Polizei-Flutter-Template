import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../overrides/button_themes.dart';
import '../overrides/card_themes.dart';
import '../overrides/container_themes.dart';

class OverrideThemeLayout extends StatelessWidget {
  const OverrideThemeLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ButtonThemes(
      child: ContainerThemes(child: CardThemes(child: child)),
    );
  }
}
