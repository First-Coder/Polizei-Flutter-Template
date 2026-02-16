import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Default alignment used for toast notifications in the app.
///
/// Centralizing this makes it easy to keep toast placement consistent across
/// different toast builders and screens.
final Alignment toastAlignment = Alignment.bottomCenter;

/// Builds a toast UI that informs the user that an external URL could not be opened.
///
/// Intended usage:
/// - Call this from a `showToast(...)` builder when `url_launcher.launchUrl(...)`
///   returns `false` or throws, indicating that the system could not open the link.
///
/// Parameters:
/// - [context]: Build context provided by the toast builder.
/// - [overlay]: The toast overlay instance provided by `shadcn_flutter`.
///   (Not currently used, but included to match typical `showToast` builder signatures
///   and to allow future enhancements like dismissing the toast programmatically.)
/// - [url]: The URL that failed to open. Displayed to the user for transparency.
///
/// Returns:
/// - A [Widget] (typically a card-like surface) suitable to be shown as toast content.
///
/// Notes:
/// - The displayed text is currently German; consider moving to i18n if needed.
/// - Consider sanitizing/shortening very long URLs for better layout stability.
Widget toastExceptionLaunchUrl(
  BuildContext context,
  ToastOverlay overlay,
  String url,
) {
  return SurfaceCard(
    child: Basic(
      title: const Text('Externe Url konnte nich geöffnet werden'),
      subtitle: Text('Die Url konnte nicht geöffnet werden: $url'),
      trailingAlignment: toastAlignment,
    ),
  );
}
