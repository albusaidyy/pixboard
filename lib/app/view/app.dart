import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixboard/l10n/l10n.dart';
import 'package:pixboard/utils/_index.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pixboard/utils/theme_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    return _ThemeSwitcher(
      child: ResponsiveSizer(
        maxTabletWidth: 900,
        builder: (context, orientation, screenType) {
          final controller = ThemeController.of(context);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: controller?.themeMode ?? ThemeMode.system,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: PixboardRouter.router,
          );
        },
      ),
    );
  }
}

class _ThemeSwitcher extends StatefulWidget {
  const _ThemeSwitcher({required this.child});
  final Widget child;

  @override
  State<_ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<_ThemeSwitcher> {
  ThemeMode _mode = ThemeMode.system;

  void _setMode(ThemeMode mode) {
    setState(() => _mode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      themeMode: _mode,
      setThemeMode: _setMode,
      child: widget.child,
    );
  }
}
