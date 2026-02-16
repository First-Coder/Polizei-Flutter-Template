import 'package:shadcn_flutter/shadcn_flutter.dart';

final Alignment toastAlignment = Alignment.bottomCenter;

Widget toastExceptionLaunchUrl(BuildContext context, ToastOverlay overlay, String url) {
  return SurfaceCard(
    child: Basic(
      title: const Text('Externe Url konnte nich geöffnet werden'),
      subtitle: Text('Die Url konnte nicht geöffnet werden: $url'),
      trailingAlignment: toastAlignment,
    ),
  );
}