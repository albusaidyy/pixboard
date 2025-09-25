import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pixboard/_shared/models/dto.dart';
import 'package:pixboard/_shared/services/profile_service.dart';
import 'package:pixboard/features/profile/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProfileService profileService,
  }) : _profileService = profileService,
       super(const ProfileState.initial()) {
    _profileService = profileService;
  }

  late ProfileService _profileService;

  Future<void> submitProfile({
    required ProfileDataDto data,
  }) async {
    emit(const ProfileState.loading());
    try {
      final postId = await _profileService.submitProfile(
        data: data,
      );
      Logger().d('Profile submitted successfully with ID: $postId');
      emit(ProfileState.success(postId));
    } on Exception catch (e) {
      Logger().f(e.toString());
      emit(ProfileState.error(e.toString()));
    }
  }
}
