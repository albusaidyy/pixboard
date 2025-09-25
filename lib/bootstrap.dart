import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixboard/_shared/services/image_service.dart';
import 'package:pixboard/features/dashboard/dashboard.dart';
import 'package:pixboard/features/profile/profile.dart';
import 'package:pixboard/utils/_index.dart';

import '_shared/services/profile_service.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  setupSingletons();

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetImagesCubit(imageService: getIt<ImageService>()),
        ),
        BlocProvider(
          create: (context) =>
              ProfileCubit(profileService: getIt<ProfileService>()),
        ),
      ],
      child: await builder(),
    ),
  );
}
