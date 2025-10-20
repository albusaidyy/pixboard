import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixboard/_shared/models/errors.dart';
import 'package:pixboard/_shared/models/image_model.dart';
import 'package:pixboard/_shared/services/image_service.dart';

part 'gallery_state.dart';
part 'gallery_cubit.freezed.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit({
    required ImageService imageService,
  }) : _imageService = imageService,
       super(const GalleryState.initial());

  final ImageService _imageService;

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      emit(const GalleryState.initial());
      return;
    }
    emit(const GalleryState.loading());
    try {
      final images = await _imageService.getImages(trimmed);
      emit(GalleryState.success(images));
    } on Failure catch (e, _) {
      emit(GalleryState.error(e.toString()));
    } on Exception catch (e, _) {
      emit(GalleryState.error(e.toString()));
    }
  }

  void reset() {
    emit(const GalleryState.initial());
  }
}
