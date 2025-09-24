import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pixboard/_shared/services/image_service.dart';
import 'package:pixboard/features/dashboard/dashboard.dart';

final GetIt getIt = GetIt.instance;

void setupSingletons() {
  getIt.registerSingleton<ImageService>(ImageServiceImpl());
}

class Singletons {
  static List<BlocProvider> registerCubits() => [
    BlocProvider(
      create: (context) => GetImagesCubit(imageService: getIt<ImageService>()),
    ),
  ];
}
