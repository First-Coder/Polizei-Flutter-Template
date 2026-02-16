import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

part 'theme_state.dart';

/// A BLoC/Cubit responsible for managing the application's theme mode and colors.
///
/// Responsibilities:
/// - Track whether the app is currently in dark mode ([isDarkMode]).
/// - Expose the active [ColorScheme] used by `shadcn_flutter` widgets ([colorScheme]).
/// - Provide commands to switch theme:
///   - [toggleTheme]
///   - [setSystemTheme]
///   - [setDarkTheme]
///   - [setLightTheme]
///
/// Data model:
/// - The public cubit state is a [ThemeState] (`LightThemeState` / `DarkThemeState`).
/// - In addition, this cubit keeps convenience fields ([_isDarkMode], [_colorScheme])
///   to support quick access and non-reactive reads.
///
/// Platform integration:
/// - [initialBrightness] reads the platform's brightness at startup using
///   `WidgetsBinding.instance.platformDispatcher.platformBrightness`.
///
/// Important note:
/// - [initialBrightness] is captured once. If the OS theme changes while the app is
///   running, you need to call [setSystemTheme] (or listen to platform changes) to
///   update the cubit accordingly.
class ThemeCubit extends Cubit<ThemeState> {
  /// Cached flag indicating whether the current mode is dark.
  late bool _isDarkMode;

  /// Returns `true` if the cubit is currently in dark mode.
  bool get isDarkMode => _isDarkMode;

  /// Cached active color scheme (from `shadcn_flutter`).
  late ColorScheme _colorScheme;

  /// Returns the currently active [ColorScheme].
  ///
  /// This is typically used by UI code that needs direct access to the scheme.
  ColorScheme get colorScheme => _colorScheme;

  /// The platform brightness at the time the cubit is created.
  ///
  /// This value does not automatically update as the OS theme changes.
  final Brightness initialBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  /// Creates the theme cubit and emits the initial theme state.
  ///
  /// Startup logic:
  /// - Determines [Brightness] from the platform (light/dark).
  /// - Picks [light] or [dark] color scheme accordingly.
  /// - Emits [LightThemeState] or [DarkThemeState].
  ThemeCubit() : super(LightThemeState()) {
    _isDarkMode = initialBrightness == Brightness.dark;
    _colorScheme = _isDarkMode ? dark : light;
    emit(_isDarkMode ? DarkThemeState() : LightThemeState());
  }

  /// Toggles between light and dark mode.
  ///
  /// This is a user-driven override and does not consider system brightness.
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _colorScheme = _isDarkMode ? dark : light;
    emit(_isDarkMode ? DarkThemeState() : LightThemeState());
  }

  /// Sets the theme based on the captured platform brightness.
  ///
  /// If the current cubit theme already matches the system brightness, this is a no-op.
  ///
  /// Note:
  /// - Because [initialBrightness] is read once at creation time, this method only
  ///   reflects that initial value unless you reconstruct the cubit or change the
  ///   implementation to read `platformDispatcher.platformBrightness` dynamically.
  void setSystemTheme() {
    if (_isDarkMode == (initialBrightness == Brightness.dark)) {
      return;
    }
    _isDarkMode = initialBrightness == Brightness.dark;
    _colorScheme = _isDarkMode ? dark : light;
    emit(_isDarkMode ? DarkThemeState() : LightThemeState());
  }

  /// Forces the theme into dark mode and emits [DarkThemeState].
  void setDarkTheme() {
    _isDarkMode = true;
    _colorScheme = dark;
    emit(DarkThemeState());
  }

  /// Forces the theme into light mode and emits [LightThemeState].
  void setLightTheme() {
    _isDarkMode = false;
    _colorScheme = light;
    emit(LightThemeState());
  }
}
