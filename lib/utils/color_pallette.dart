import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

const _leaf = Color(0xFF43A047); // leaf green
const _leafDark = Color(0xFF2E7D32);
const _wood = Color(0xFF8D6E63); // warm wood
const _woodDark = Color(0xFF6D4C41);
const _accent = Color(0xFF26A69A); // teal-ish accent

final ThemeData lightTheme = FlexThemeData.light(
  useMaterial3: true,
  colors: const FlexSchemeColor(
    primary: _leaf,
    primaryContainer: Color(0xFFB9E4C0),
    secondary: _wood,
    secondaryContainer: Color(0xFFD7C0B8),
    tertiary: _accent,
    tertiaryContainer: Color(0xFFB2DFDB),
    appBarColor: _wood,
    error: Color(0xFFB00020),
  ),
  surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
  blendLevel: 10,
);

final ThemeData darkTheme = FlexThemeData.dark(
  useMaterial3: true,
  colors: const FlexSchemeColor(
    primary: _leafDark,
    primaryContainer: Color(0xFF274C2F),
    secondary: _woodDark,
    secondaryContainer: Color(0xFF49352C),
    tertiary: Color(0xFF00897B),
    tertiaryContainer: Color(0xFF004D40),
    appBarColor: _woodDark,
    error: Color(0xFFCF6679),
  ),
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 14,
);
