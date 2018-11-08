import 'package:flutter/material.dart';
import 'package:simple_flutter/storage/sp/sp_storage.dart';
import 'package:simple_flutter/style/global_colors.dart';

class ThemeDataManager {
  static const String KEY_CURRENT_THEME = "key_current_theme";

  static const Color themeColorDefault = Colors.blue;

  static const MaterialColor darkSwatch = const MaterialColor(
    0xFF24292E,
    const <int, Color>{
      50: const Color(0xFF42464b),
      100: const Color(0xFF42464b),
      200: const Color(0xFF42464b),
      300: const Color(0xFF42464b),
      400: const Color(0xFF42464b),
      500: const Color(0xFF24292E),
      600: const Color(0xFF121917),
      700: const Color(0xFF121917),
      800: const Color(0xFF121917),
      900: const Color(0xFF121917),
    },
  );

  static List<Color> themeColorList = [
    themeColorDefault,
    Colors.green,
    Colors.brown,
    Colors.red,
    Colors.amber,
    Colors.indigo,
    darkSwatch,
  ];

  static ThemeData defTheme() {
    return _buildLightTheme(themeColorList[0]);
  }

  static ThemeData buildTheme(Color color) {
    if (color.value == themeColorList[themeColorList.length - 1].value) {
      return _buildDarkTheme(color);
    } else {
      return _buildLightTheme(color);
    }
  }

  static ThemeData _buildLightTheme(Color color) {
    Color primaryColor = color;
    Color secondaryColor = color;
    ColorScheme colorScheme = ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();

    Color coPrimary = Colors.white;
    Color coAccent = Colors.white24;
    return _buildThemeData(
        base, colorScheme, primaryColor, secondaryColor, coPrimary, coAccent);
  }

  static ThemeData _buildDarkTheme(Color color) {
    Color primaryColor = color;
    Color secondaryColor = color;
    ColorScheme colorScheme = ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();

    Color coPrimary = Colors.black87;
    Color coAccent = Colors.black54;

    return _buildThemeData(
        base, colorScheme, primaryColor, secondaryColor, coPrimary, coAccent);
  }

  static _buildThemeData(
      ThemeData base,
      ColorScheme colorScheme,
      Color primaryColor,
      Color secondaryColor,
      Color coPrimary,
      Color coAccent) {
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      accentColor: secondaryColor,
      buttonColor: primaryColor,
      indicatorColor: coPrimary,
      splashColor: coAccent,
      splashFactory: InkRipple.splashFactory,
      canvasColor: coPrimary,
      scaffoldBackgroundColor: coPrimary,
      backgroundColor: coPrimary,
      errorColor: Colors.redAccent,
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }

  static _buildTextTheme(TextTheme base) {
    return base.copyWith(title: base.title.copyWith(fontFamily: 'GoogleSans'));
  }
}
