import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:police_flutter_template/screens/widgets/code_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

class Installation extends StatelessWidget {
  const Installation({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return Container(
      width: double.infinity,
      color: isDarkMode ? Colors.gray[900] : Colors.white,
      child: Column(
        children: [
          Text('Installation').bold.responsive(
            context,
            mobile: (t) => t.x3Large,
            tablet: (t) => t.x3Large,
            desktop: (t) => t.x4Large,
          ),
          Gap(16),
          Text(
            'Starten Sie in wenigen Minuten mit dem Flutter Template',
          ).setColors(
            lightColor: Colors.gray[600],
            darkColor: Colors.gray[400],
          ),
          Gap(48),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 900),
            child: CodeCard(
              title: 'Installation in flutter',
              lines: [
                CodeCommentLine("# Repository klonen"),
                CodeTextLine(
                  "git clone https://github.com/First-Coder/Polizei-Flutter-Template.git",
                ),
                CodeTextLine("cd police_flutter_template"),
              ],
            ),
          ).withPadding(horizontal: 20),
        ],
      ).withPadding(vertical: 64),
    );
  }
}
