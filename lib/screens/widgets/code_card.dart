import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../extensions/text_extensions.dart';
import '../../theme/cubit/theme_cubit.dart';

/// Represents a single renderable line inside a [CodeCard].
///
/// Use one of the concrete subclasses to describe what should be displayed:
/// - [CodeTextLine] for regular code text (usually rendered in a monospace style)
/// - [CodeCommentLine] for comment text (usually rendered muted)
/// - [CodeWidgetLine] for embedding an arbitrary widget (e.g. a button, badge, input)
///
/// This sealed hierarchy also allows [CodeCard] to build a “copy to clipboard”
/// string by extracting text from supported line types.
sealed class CodeLine {
  /// Base constructor for all code line types.
  const CodeLine();
}

/// A plain text line that is rendered as code.
///
/// This line is included in the copied-to-clipboard output.
class CodeTextLine extends CodeLine {
  /// Creates a text line containing [text].
  const CodeTextLine(this.text);

  /// The code text to render and include in the clipboard copy.
  final String text;
}

/// A comment line (e.g. `# ...` or `// ...`) that is rendered in a muted style.
///
/// This line is included in the copied-to-clipboard output.
class CodeCommentLine extends CodeLine {
  /// Creates a comment line containing [text].
  const CodeCommentLine(this.text);

  /// The comment text to render and include in the clipboard copy.
  final String text;
}

/// A line that renders a custom [widget] inside the code block.
///
/// By default, widget lines are *not* included in the copied output.
/// If you want a widget line to contribute text to the clipboard copy,
/// provide [includeInCopyAs].
class CodeWidgetLine extends CodeLine {
  /// Creates a widget line.
  ///
  /// - [widget] is rendered visually inside the code area.
  /// - [includeInCopyAs] (optional) is appended to the copied code string.
  const CodeWidgetLine(this.widget, {this.includeInCopyAs});

  /// The widget to render in place of a text line.
  final Widget widget;

  /// Optional text representation used when the user copies the code.
  ///
  /// If null, this line will be omitted from the clipboard output.
  final String? includeInCopyAs;
}

/// A card widget that displays a titled code snippet with a “copy” action.
///
/// [CodeCard] renders:
/// - a header row with a terminal icon and [title]
/// - an optional [description]
/// - a code-like container that lists [lines]
/// - a copy button that puts the assembled code text onto the clipboard
///
/// ## Clipboard behavior
/// The copied string is produced by iterating over [lines]:
/// - [CodeTextLine.text] is included
/// - [CodeCommentLine.text] is included
/// - [CodeWidgetLine.includeInCopyAs] is included if not null
/// Each included line is joined with `\n`.
///
/// ## Theming
/// The component adapts its colors based on the app's theme state
/// (e.g. dark mode), typically read from a [ThemeCubit].
///
/// ## Example
/// ```dart
/// CodeCard(
///   title: 'Installation',
///   description: 'Get started in minutes.',
///   lines: const [
///     CodeCommentLine('# Clone the repository'),
///     CodeTextLine('git clone <REPO_URL>'),
///     CodeTextLine('cd my_project'),
///   ],
/// )
/// ```
class CodeCard extends StatelessWidget {
  const CodeCard({
    super.key,
    required this.title,
    this.description,
    required this.lines,
  });

  /// The title shown in the header row.
  final String title;

  /// Optional supporting text shown below the title.
  final String? description;

  /// The content lines rendered inside the code container.
  ///
  /// Use [CodeTextLine], [CodeCommentLine], and [CodeWidgetLine].
  final List<CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    final codeText = lines
        .map((line) {
          if (line is CodeTextLine) return line.text;
          if (line is CodeCommentLine) return line.text;
          if (line is CodeWidgetLine) return line.includeInCopyAs;
          return null;
        })
        .whereType<String>()
        .join('\n');

    return Card(
      filled: true,
      fillColor: isDarkMode ? Colors.gray[800] : Colors.transparent,
      borderColor: isDarkMode ? Colors.gray[700] : Colors.gray[300],
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [const Icon(LucideIcons.terminal), Text(title).semiBold],
          ).gap(10),
          if (description != null) ...[Gap(10), Text(description!).muted],
          Gap(24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.gray[700] : Colors.gray[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: lines
                      .map(
                        (line) => (line is CodeWidgetLine
                            ? line.widget
                            : line is CodeTextLine
                            ? Text(
                                line.text,
                              ).mono.small.setColors(lightColor: Colors.white)
                            : line is CodeCommentLine
                            ? Text(line.text).mono.small.muted
                            : SizedBox.shrink()),
                      )
                      .toList(),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    size: ButtonSize.small,
                    icon: const Icon(LucideIcons.copy),
                    variance: ButtonVariance.secondary,
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: codeText));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
