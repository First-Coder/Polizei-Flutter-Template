import 'package:shadcn_flutter/shadcn_flutter.dart';

/// SearchEngine provides the configuration and data source for the app-wide
/// command palette (search/command menu).
///
/// It is designed to be passed into the `Command` widget (from `shadcn_flutter`)
/// via:
/// - `builder` (see [queryBuilder])
/// - `searchPlaceholder`
/// - `loadingBuilder`
/// - `emptyBuilder`
///
/// The engine is responsible for:
/// - deciding whether search should be available ([showSearch])
/// - providing placeholder text for the input ([searchPlaceholder])
/// - rendering loading and empty states
/// - emitting incremental results as a `Stream<List<Widget>>`
///
/// Notes:
/// - [queryBuilder] currently uses a small in-memory demo dataset.
/// - Results are grouped into categories and yielded with an artificial delay
///   to demonstrate incremental streaming.
class SearchEngine {
  /// Whether the search UI entrypoint should be shown (e.g. a search icon).
  ///
  /// The UI can use this flag to conditionally render search controls.
  final bool showSearch = true;

  /// Placeholder widget displayed inside the command palette search field.
  ///
  /// Keep this short and instructive. This is a `Widget` to allow rich styling,
  /// icons, etc.
  final Widget? searchPlaceholder = const Text(
    'Geben Sie einen Befehl ein oder suchen Sie',
  );

  /// Builder for the "loading" state while results are being produced.
  ///
  /// Used by the `Command` widget when the results stream has not emitted
  /// anything yet or is still fetching data.
  Widget loadingBuilder(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  /// Builder for the "empty" state when the query yields no results.
  ///
  /// Used by the `Command` widget when the results stream completes without
  /// returning any matches for the provided query.
  Widget emptyBuilder(BuildContext context) {
    return const Center(child: Text('Keine Ergebnisse gefunden'));
  }

  /// Produces search results for the command palette.
  ///
  /// The `Command` widget calls this whenever the search query changes.
  /// This function returns a `Stream` so results can be emitted incrementally.
  ///
  /// Parameters:
  /// - [context]: Build context from the `Command` widget.
  /// - [query]: The current user input. If `null`, all items are considered.
  ///
  /// Output:
  /// - Each stream event is a list of widgets, typically containing one
  ///   [CommandCategory] with multiple [CommandItem] children.
  ///
  /// Behavior:
  /// - Filters items case-insensitively by substring match.
  /// - Groups results by category ("Suggestions", "Settings", ...).
  /// - Yields categories one by one with a short delay to simulate latency.
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
    for (final values in items.entries) {
      List<Widget> resultItems = [];
      for (final item in values.value) {
        if (query == null || item.toLowerCase().contains(query.toLowerCase())) {
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