import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixboard/_shared/models/image_model.dart';
import 'package:pixboard/_shared/services/image_service.dart';

part 'get_images_state.dart';
part 'get_images_cubit.freezed.dart';

class GetImagesCubit extends Cubit<GetImagesState> {
  GetImagesCubit({
    required ImageService imageService,
  }) : _imageService = imageService,
       super(const GetImagesState.initial()) {
    _imageService = imageService;
  }

  late ImageService _imageService;

  Future<void> getDashboardImages(String query) async {
    emit(const GetImagesState.loading());
    try {
      final images = await _imageService.getImages('');
      emit(GetImagesState.success(images));
    } on Exception catch (e, _) {
      emit(const GetImagesState.error('Something went wrong'));
    }
  }
}
