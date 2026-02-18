import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../extensions/text_extensions.dart';
import '../../theme/cubit/theme_cubit.dart';
import 'code_card.dart';

/// A widget that renders a standalone block of code with a copy-to-clipboard action.
///
/// [CodeBlock] provides a styled, monospace-oriented container for displaying 
/// multi-line code snippets. It is designed to be used as a sub-component or 
/// a simpler alternative to [CodeCard].
///
/// The block supports different types of lines via the [CodeLine] hierarchy:
/// * [CodeTextLine] for standard code text.
/// * [CodeCommentLine] for comments (rendered in a muted style).
/// * [CodeWidgetLine] for embedding custom widgets within the code layout.
///
/// ## Features
/// * **Theming**: Automatically adjusts its background and border colors based on 
///   the current [ThemeCubit] state.
/// * **Clipboard**: Includes a "copy" button in the top-right corner that 
///   assembles all text-based lines into the system clipboard.
/// * **Monospace**: Renders text using a monospace font style for a "code" look.
///
/// ## Example
/// ```dart
/// CodeBlock(
///   lines: [
///     CodeCommentLine('// Initialize the app'),
///     CodeTextLine('await App.init();'),
///   ],
/// )
/// ```
class CodeBlock extends StatelessWidget {
  /// Creates a [CodeBlock].
  const CodeBlock({
    super.key,
    required this.lines,
  });

  /// The list of [CodeLine] objects to be rendered sequentially.
  ///
  /// These lines determine both the visual output and the content copied 
  /// when the user clicks the copy button.
  final List<CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    // Assemble the full text string for clipboard operations.
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
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            : const SizedBox.shrink()),
                      )
                      .toList(),
                ),
                Positioned(
                  right: 0,
                  top: 0,
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
