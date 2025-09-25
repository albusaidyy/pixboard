import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
    } on Exception {
      emit(
        const GalleryState.error('Failed to load images. Please try again.'),
      );
    }
  }

  void reset() {
    emit(const GalleryState.initial());
  }
}
