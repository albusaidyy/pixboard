import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.indigoM3,
  primary: const Color(0xFF6750A4),
  secondary: const Color(0xFF03DAC6),
  surface: Colors.white,
);

final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.indigoM3,
  primary: const Color(0xFF6750A4),
  secondary: const Color(0xFF03DAC6),
  surface: const Color(0xFF1E1E1E),
);
