import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A simple responsive layout switcher that chooses between mobile/tablet/desktop widgets.
///
/// This widget is intended for *coarse* responsive layout decisions:
/// - provide three prebuilt widgets ([mobile], [tablet], [desktop])
/// - `Responsive` selects one based on the available width
///
/// Breakpoints:
/// - Mobile: `< 650`
/// - Tablet: `>= 650 && < 1100`
/// - Desktop: `>= 1100`
///
/// Notes:
/// - The internal `LayoutBuilder` uses `constraints.maxWidth` (not `MediaQuery`) to
///   support embedding inside constrained containers.
/// - There is a minor discrepancy: `build()` uses a desktop threshold of `>= 1000`,
///   while [isDesktop] uses `>= 1100`. Keep that in mind if you rely on the static
///   helpers and the widget in the same screen.
///
/// Platform helper:
/// - [isTouchDevice] returns true on iOS/Android when not running on web.
///   This is useful to gate hover interactions and similar desktop-only affordances.
class Responsive extends StatelessWidget {
  /// Creates a responsive switcher.
  const Responsive({
    super.key,
    required this.desktop,
    required this.mobile,
    required this.tablet,
  });

  /// Widget tree used for mobile widths.
  final Widget mobile;

  /// Widget tree used for tablet widths.
  final Widget tablet;

  /// Widget tree used for desktop widths.
  final Widget desktop;

  /// Whether the current platform is a touch-first device (iOS/Android) and not web.
  static bool get isTouchDevice =>
      !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  /// Returns true if the current screen width is considered mobile.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  /// Returns true if the current screen width is considered tablet.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  /// Returns true if the current screen width is considered desktop.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  /// Returns true if the current screen width is at least [maxWidth].
  ///
  /// Useful for simple breakpoint checks without introducing additional constants.
  static bool isMaxWidth(BuildContext context, double maxWidth) =>
      MediaQuery.of(context).size.width >= maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If our width is more than 1100 then we consider it a desktop
        if (constraints.maxWidth >= 1000) {
          return desktop;
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
