import 'package:flutter/material.dart';
import 'package:pixboard/features/main/mobile_main_page.dart';
import 'package:pixboard/features/main/web_main_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.currentIndex});

  final int? currentIndex;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    late final StatefulWidget screenTypeView;

    switch (Device.screenType) {
      case ScreenType.mobile:
        screenTypeView = MobileMainPage(
          key: const Key('mobile_main_page'),
          currentIndex: widget.currentIndex,
        );
      case ScreenType.tablet:
        screenTypeView = WebMainPage(
          key: const Key('web_main_page'),
          currentIndex: widget.currentIndex,
        );
      // ScreenType can only be desktop when `maxTabletWidth`
      // is set in `ResponsiveSizer`
      case ScreenType.desktop:
        screenTypeView = WebMainPage(
          key: const Key('web_main_page'),
          currentIndex: widget.currentIndex,
        );
    }
    return screenTypeView;
  }
}
