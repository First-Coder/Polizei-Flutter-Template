
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  /// The current color mode
  late bool _isDarkMode;

  bool get isDarkMode => _isDarkMode;

  /// The current color scheme
  late ColorScheme _colorScheme;

  ColorScheme get colorScheme => _colorScheme;

  /// The initial brightness
  final Brightness initialBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  /// Create a new theme cubit
  ThemeCubit() : super(LightThemeState()) {
    _isDarkMode = initialBrightness == Brightness.dark;
    _colorScheme = _isDarkMode ? dark : light;
    emit(_isDarkMode ? DarkThemeState() : LightThemeState());
  }

  /// Toggle the theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _colorScheme = _isDarkMode ? dark : light;
    emit(_isDarkMode ? DarkThemeState() : LightThemeState());
  }

  /// Set system theme
  void setSystemTheme() {
    if (_isDarkMode == (initialBrightness == Brightness.dark)) {
      return;
    }
    _isDarkMode = initialBrightness == Brightness.dark;
    _colorScheme = _isDarkMode ? dark : light;
    emit(_isDarkMode ? DarkThemeState() : LightThemeState());
  }

  /// Set the theme to dark
  void setDarkTheme() {
    _isDarkMode = true;
    _colorScheme = dark;
    emit(DarkThemeState());
  }

  /// Set the theme to light
  void setLightTheme() {
    _isDarkMode = false;
    _colorScheme = light;
    emit(LightThemeState());
  }
}
