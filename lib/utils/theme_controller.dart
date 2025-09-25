import 'package:flutter/material.dart';

class ThemeController extends InheritedWidget {
  const ThemeController({
    required this.themeMode,
    required this.setThemeMode,
    required super.child,
    super.key,
  });

  final ThemeMode themeMode;
  final void Function(ThemeMode mode) setThemeMode;

  static ThemeController? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeController>();

  @override
  bool updateShouldNotify(ThemeController oldWidget) =>
      oldWidget.themeMode != themeMode;
}
