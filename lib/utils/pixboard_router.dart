import 'package:go_router/go_router.dart';
import 'package:pixboard/features/dashboard/view/dashboard_page.dart';
import 'package:pixboard/features/gallery/view/gallery_page.dart';
import 'package:pixboard/features/main/_main_page.dart';
import 'package:pixboard/features/profile/view/profile_page.dart';

class PixboardRouter {
  static GoRouter get router => _router;

  static const String main = '/';
  static const String dashboard = '/dashboard';
  static const String gallery = '/gallery';
  static const String profile = '/profile';

  static final _router = GoRouter(
    initialLocation: '/',

    routes: <GoRoute>[
      GoRoute(
        path: main,
        name: main,
        builder: (context, state) {
          final currentIndex = state.extra as int?;
          return MainPage(currentIndex: currentIndex);
        },
      ),
      GoRoute(
        path: dashboard,
        name: dashboard,
        builder: (context, state) => const DashBoardPage(),
      ),
      GoRoute(
        path: gallery,
        name: gallery,
        builder: (context, state) => const GalleryPage(),
      ),
      GoRoute(
        path: profile,
        name: profile,
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
