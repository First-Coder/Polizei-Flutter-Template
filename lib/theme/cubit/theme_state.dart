part of 'theme_cubit.dart';

/// Project-specific color shades used for branding.
///
/// This palette encodes the "Berlin Police Blue" color range (roughly from light
/// tints to strong primary tones).
///
/// Notes:
/// - Some shades are set to `Colors.transparent` (50/900/950). If this is intentional
///   (e.g. reserved slots), it is fine; otherwise consider replacing with real colors
///   to avoid surprising UI results when those indices are used.
final berlinPoliceBlue = ColorShades.fromMap({
  50: Colors.transparent,
  100: Color.fromRGBO(232, 237, 245, 1),
  200: Color.fromRGBO(207, 220, 229, 1),
  300: Color.fromRGBO(155, 198, 222, 1),
  400: Color.fromRGBO(118, 164, 215, 1),
  500: Color.fromRGBO(17, 68, 170, 1),
  600: Color.fromRGBO(0, 51, 153, 1),
  700: Color.fromRGBO(0, 42, 128, 1),
  800: Color.fromRGBO(22, 62, 101, 1),
  900: Colors.transparent,
  950: Colors.transparent,
});

/// Global border radius used by theme components (buttons, cards, etc.).
///
/// `shadcn_flutter` uses `ThemeData.radius` as a styling primitive.
final double radius = 0.5;

/// The light mode [ColorScheme] used across the app.
///
/// Based on `shadcn_flutter`'s `lightSlate.blue` preset, with a stronger primary
/// and a white primary foreground for contrast.
final ColorScheme light = ColorSchemes.lightSlate.blue.copyWith(
  primary: () => Colors.blue[900],
  primaryForeground: () => Colors.white,
);

/// The light [ThemeData] for `shadcn_flutter`.
///
/// This is the object you typically pass into `ShadcnApp` / theme providers.
final ThemeData lightTheme = ThemeData(colorScheme: light, radius: radius);

/// The dark mode [ColorScheme] used across the app.
///
/// Based on `shadcn_flutter`'s `darkSlate.blue` preset, tweaked to:
/// - use a slightly lighter primary for dark backgrounds
/// - set card backgrounds for better contrast
final ColorScheme dark = ColorSchemes.darkSlate.blue.copyWith(
  primary: () => Colors.blue[700],
  primaryForeground: () => Colors.white,
  card: () => Colors.gray[800],
);

/// The dark [ThemeData] for `shadcn_flutter`.
final ThemeData darkTheme = ThemeData(colorScheme: dark, radius: radius);

/// Base state emitted by [ThemeCubit].
///
/// A [ThemeState] encapsulates everything the UI needs to render consistently:
/// - [themeData]: `shadcn_flutter` theme configuration (colors, radius, etc.)
/// - [isDarkMode]: a convenient boolean for quick branching in widgets
/// - [colorScheme]: the active scheme (light/dark)
///
/// States are immutable to support predictable rendering and simple comparisons.
@immutable
abstract class ThemeState {
  /// Theme configuration used by `shadcn_flutter` widgets.
  final ThemeData themeData;

  /// Whether this state represents dark mode.
  final bool isDarkMode;

  /// Active color scheme (light/dark).
  final ColorScheme colorScheme;

  /// Creates a theme state.
  const ThemeState(this.themeData, this.colorScheme, this.isDarkMode);
}

/// Theme state representing light mode.
///
/// Uses [lightTheme] and [light] color scheme.
final class LightThemeState extends ThemeState {
  LightThemeState() : super(lightTheme, light, false);
}

/// Theme state representing dark mode.
///
/// Uses [darkTheme] and [dark] color scheme.
final class DarkThemeState extends ThemeState {
  DarkThemeState() : super(darkTheme, dark, true);
}
