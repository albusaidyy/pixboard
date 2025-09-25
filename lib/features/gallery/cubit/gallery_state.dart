part of 'gallery_cubit.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState.initial() = GalleryInitial;
  const factory GalleryState.loading() = GalleryLoading;
  const factory GalleryState.success(List<PixImage> images) = GallerySuccess;
  const factory GalleryState.error(String message) = GalleryError;
}
