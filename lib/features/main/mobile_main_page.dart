import 'package:flutter/material.dart';
import 'package:pixboard/features/dashboard/dashboard.dart';
import 'package:pixboard/features/gallery/gallery.dart';
import 'package:pixboard/features/profile/profile.dart';
import 'package:pixboard/utils/_index.dart';

class MobileMainPage extends StatefulWidget {
  const MobileMainPage({super.key, this.currentIndex});

  final int? currentIndex;

  @override
  State<MobileMainPage> createState() => _MobileSignInState();
}

class _MobileSignInState extends State<MobileMainPage> {
  final currentIndexNotifier = ValueNotifier<int>(0);

  final List<StatefulWidget> _children = [
    const DashBoardPage(),
    const GalleryPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    currentIndexNotifier.value = widget.currentIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndexNotifier,
      builder: (context, currentIndex, _) {
        return Scaffold(
          body: _children[currentIndex],
          appBar: AppBar(title: const Text('PixBoard')),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Drawer Header
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.addOpacity(0.8),
                  ),
                  child: const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'PixBoard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Dashboard
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Dashboard'),
                  selected: currentIndex == 0,
                  onTap: () {
                    Navigator.pop(context);
                    currentIndexNotifier.value = 0;
                  },
                ),

                // Gallery
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  selected: currentIndex == 1,
                  onTap: () {
                    Navigator.pop(context);
                    currentIndexNotifier.value = 1;
                  },
                ),

                // Profile
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  selected: currentIndex == 2,
                  onTap: () {
                    Navigator.pop(context);
                    currentIndexNotifier.value = 2;
                  },
                ),

                const Divider(),

                // Logout
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle logout logic
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
