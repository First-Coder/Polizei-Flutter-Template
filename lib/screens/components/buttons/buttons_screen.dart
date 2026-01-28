import 'package:police_flutter_template/screens/widgets/error_pages/not_found_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotFoundCard().withPadding(vertical: 64, horizontal: 16);
  }
}
