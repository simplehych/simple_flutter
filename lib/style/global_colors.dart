import 'package:flutter/material.dart';

class GlobalColors {
  static const int white = 0xffffffff;

  static const int primaryLightValue = 0xFFBBDEFB;
  static const int primaryValue = 0xFF2196F3;
  static const int primaryDarkValue = 0xFF1565C0;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(primaryValue),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

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

}
