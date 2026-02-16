import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Provides configuration and a data source for an app-wide command palette
/// (search / command menu).
///
/// This class is designed to be consumed by the `Command` widget from `shadcn_flutter`,
/// typically by providing:
/// - `builder` (see [queryBuilder])
/// - [searchPlaceholder]
/// - [loadingBuilder]
/// - [emptyBuilder]
///
/// Responsibilities:
/// - Define whether search is available ([showSearch])
/// - Provide placeholder content ([searchPlaceholder])
/// - Render loading and empty states
/// - Produce incremental results as a `Stream<List<Widget>>` via [queryBuilder]
///
/// Current behavior:
/// - Uses a small in-memory demo dataset.
/// - Filters items with a case-insensitive substring check.
/// - Groups results by category.
/// - Emits categories incrementally with an artificial delay to demonstrate streaming.
///
/// Production considerations:
/// - Replace the in-memory dataset with an injected data source (e.g. repository/service).
/// - Consider debouncing, cancellation, and error handling for real backends.
/// - Move user-facing strings to i18n (currently German).
class SearchEngine {
  /// Whether the search UI entrypoint should be shown (e.g. search icon / shortcut).
  final bool showSearch = true;

  /// Placeholder widget displayed inside the command palette search field.
  ///
  /// Kept as a [Widget] to allow icons, styled text, etc.
  final Widget? searchPlaceholder = const Text(
    'Geben Sie einen Befehl ein oder suchen Sie',
  );

  /// Builder for the "loading" state while results are being produced.
  Widget loadingBuilder(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  /// Builder for the "empty" state when the query yields no results.
  Widget emptyBuilder(BuildContext context) {
    return const Center(child: Text('Keine Ergebnisse gefunden'));
  }

  /// Produces command palette results for the current [query].
  ///
  /// Why a stream:
  /// - Allows incremental rendering (fast perceived performance)
  /// - Supports progressive grouping (emit category by category)
  ///
  /// Parameters:
  /// - [context]: Build context from the consuming command palette widget.
  /// - [query]: User input. If `null`, all items are considered.
  ///
  /// Output:
  /// - Each emitted event is a list of widgets, typically one [CommandCategory]
  ///   containing multiple [CommandItem] children.
  ///
  /// Implementation details:
  /// - Filtering is case-insensitive substring match.
  /// - A short delay simulates latency to demonstrate progressive results.
  Stream<List<Widget>> queryBuilder(
    BuildContext context,
    String? query,
  ) async* {
    Map<String, List<String>> items = {
      'Suggestions': ['Calendar', 'Search Emoji', 'Launch'],
      'Settings': ['Profile', 'Mail', 'Settings'],
    };

    Map<String, Widget> icons = {
      'Calendar': const Icon(Icons.calendar_today),
      'Search Emoji': const Icon(Icons.emoji_emotions_outlined),
      'Launch': const Icon(Icons.rocket_launch_outlined),
      'Profile': const Icon(Icons.person_outline),
      'Mail': const Icon(Icons.mail_outline),
      'Settings': const Icon(Icons.settings_outlined),
    };

    // Emit results category-by-category to demonstrate incremental streaming.
    for (final values in items.entries) {
      List<Widget> resultItems = [];

      for (final item in values.value) {
        final matches =
            query == null || item.toLowerCase().contains(query.toLowerCase());
        if (matches) {
          resultItems.add(
            CommandItem(title: Text(item), leading: icons[item], onTap: () {}),
          );
        }
      }

      if (resultItems.isNotEmpty) {
        // Simulate latency to showcase incremental results.
        await Future.delayed(const Duration(seconds: 1));
        yield [CommandCategory(title: Text(values.key), children: resultItems)];
      }
    }
  }
}
