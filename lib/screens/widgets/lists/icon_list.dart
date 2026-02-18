import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';
import 'models/icon_list_model.dart';

/// Renders a vertical list of icon-based items using `shadcn_flutter` components.
///
/// Each row is built with [Basic] and uses an `IconContainer` as the leading widget.
/// Colors can be provided in a theme-aware way via [IconListModel]:
/// - light mode: [IconListModel.iconColor] / [IconListModel.color]
/// - dark mode:  [IconListModel.iconColorDark] / [IconListModel.colorDark]
///
/// Theme integration:
/// - Reads the current dark/light mode from [ThemeCubit] using `context.watch`.
/// - This means the widget will rebuild automatically when the theme mode changes.
///
/// Layout:
/// - Implemented as a [Column] with `crossAxisAlignment: CrossAxisAlignment.start`.
/// - Adds vertical spacing between rows via `.gap(10)`.
///
/// Performance note:
/// - For very large lists, prefer a `ListView.builder` to avoid building every row at once.
class IconList extends StatelessWidget {
  const IconList({super.key, required this.items});

  /// Items to be rendered as rows.
  final List<IconListModel> items;

  @override
  Widget build(BuildContext context) {
    // Read the current theme mode from the theme cubit.
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => (Basic(
              leading: IconContainer(
                icon: Icon(item.icon),
                iconColor: item.iconColor == null
                    ? null
                    : isDarkMode
                    ? item.iconColorDark
                    : item.iconColor,
                backgroundColor: item.color == null
                    ? null
                    : isDarkMode
                    ? item.colorDark
                    : item.color,
              ),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
            )),
          )
          .toList(),
    ).gap(10);
  }
}
