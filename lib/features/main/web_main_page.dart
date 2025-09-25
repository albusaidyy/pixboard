import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixboard/features/dashboard/dashboard.dart';
import 'package:pixboard/features/gallery/gallery.dart';
import 'package:pixboard/features/profile/profile.dart';

class WebMainPage extends StatefulWidget {
  const WebMainPage({super.key, this.currentIndex});

  final int? currentIndex;

  @override
  State<WebMainPage> createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {
  final currentIndexNotifier = ValueNotifier<int>(0);
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAlignment = -1;

  final List<StatefulWidget> _pages = const [
    DashBoardPage(),
    GalleryPage(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetImagesCubit>().getDashboardImages('popular');
    });

    currentIndexNotifier.value = widget.currentIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndexNotifier,
      builder: (context, currentIndex, _) {
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                NavigationRail(
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  selectedIndex: currentIndex,
                  groupAlignment: groupAlignment,
                  labelType: labelType,
                  onDestinationSelected: (index) {
                    currentIndexNotifier.value = index;
                  },
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.photo_library_outlined),
                      selectedIcon: Icon(Icons.photo_library),
                      label: Text('Gallery'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                Expanded(
                  child: _pages[currentIndex],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
