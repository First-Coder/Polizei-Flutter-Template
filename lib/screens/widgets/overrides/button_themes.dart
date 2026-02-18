import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonThemes extends StatelessWidget {
  const ButtonThemes({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ComponentTheme(
      data: SecondaryButtonTheme(
        decoration: (context, states, defaultDecoration) {
          return defaultDecoration;
          // return defaultDecoration.copyWithIfBoxDecoration(
          //   color: Colors.red,
          //   border: Border.all(color: Colors.green, width: 10),
          // );
        },
      ),
      child: child,
    );
  }
}
