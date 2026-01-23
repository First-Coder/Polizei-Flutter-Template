part of 'theme_cubit.dart';

/// The berlin police blue color scheme.
final berlinPoliceBlue = ColorShades.fromAccent(Color(0xFF005A8C));

/// The radius of the buttons, cards etc.
final double radius = 0.5;

/// The light theme color scheme.
final ColorScheme light = ColorSchemes.lightBlue.copyWith(
  primary: () => Colors.blue[900],
  // card: () => const Color(0xFFF6F6F6),
  // background: () => const Color(0xFFE3E4E7),
  // border: () => const Color(0xFFC4C6C6),

  // primary: () => const Color(0xFFB6C1FC),

  // card: const Color(0xFFECECEC),
  // background: const Color(0xFFE4E4E4),
  // border: const Color(0xFFD9D9D9),

  // background: const Color(0xFFE4E4E4),
  // muted: Colors.white,
  // ring: ColorSchemes.lightNeutral().primary,
  // card: const Color(0xFFF2F2F2),
  // border: const Color(0xFFD3D3D3),
);

/// The light theme data.
final ThemeData lightTheme = ThemeData(
  colorScheme: light,
  radius: radius,
  // typography: Typography.geist(
  //   mono: GoogleFonts.kanit(),
  //   semiBold: GoogleFonts.kanit(),
  //   small: GoogleFonts.kanit(),
  //   medium: GoogleFonts.kanit(),
  // ),
);

/// The dark theme color scheme.
final ColorScheme dark = ColorSchemes.darkBlue.copyWith(
  primary: () => Colors.blue[700],
  primaryForeground: () => Colors.white,
  // card: () => const HSLColor.fromAHSL(1, 222.2, 0.84, 0.1).toColor(),
  // background: const Color(0xFF1F2327),
  // card: const Color(0xFF282E32),
  // input: Colors.white,
  // border: const Color(0xFF323536),
);

/// The dark theme data.
final ThemeData darkTheme = ThemeData(
  colorScheme: dark,
  radius: radius,
  // typography: Typography.geist(
  //   mono: GoogleFonts.kanit(),
  //   semiBold: GoogleFonts.kanit(),
  //   small: GoogleFonts.kanit(),
  //   medium: GoogleFonts.kanit(),
  //   base: GoogleFonts.kanit(),
  //   black: GoogleFonts.kanit(),
  // ),
);

/// The theme data based on the context of the app
@immutable
abstract class ThemeState {
  /// The theme data based on the context of the app
  final ThemeData themeData;

  /// The current color mode
  final bool isDarkMode;

  /// The current color scheme
  final ColorScheme colorScheme;

  const ThemeState(this.themeData, this.colorScheme, this.isDarkMode);
}

/// The light theme state.
final class LightThemeState extends ThemeState {
  LightThemeState() : super(lightTheme, light, false);
}

/// The dark theme state.
final class DarkThemeState extends ThemeState {
  DarkThemeState() : super(darkTheme, dark, true);
}
