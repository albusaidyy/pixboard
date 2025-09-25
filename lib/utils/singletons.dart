import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pixboard/_shared/services/image_service.dart';
import 'package:pixboard/_shared/services/profile_service.dart';
import 'package:pixboard/features/dashboard/dashboard.dart';
import 'package:pixboard/features/profile/profile.dart';
import 'package:pixboard/features/gallery/gallery.dart';
import 'package:pixboard/features/gallery/cubit/gallery_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupSingletons() {
  getIt.registerSingleton<ImageService>(ImageServiceImpl());
  getIt.registerSingleton<ProfileService>(ProfileServiceImpl());
}

class Singletons {
  static List<BlocProvider> registerCubits() => [
    BlocProvider(
      create: (context) => GetImagesCubit(imageService: getIt<ImageService>()),
    ),
    BlocProvider(
      create: (context) =>
          ProfileCubit(profileService: getIt<ProfileService>()),
    ),
    BlocProvider(
      create: (context) => GalleryCubit(imageService: getIt<ImageService>()),
    ),
  ];
}
