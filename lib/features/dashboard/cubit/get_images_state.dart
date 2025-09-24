part of 'get_images_cubit.dart';

@freezed
class GetImagesState with _$GetImagesState {
  const factory GetImagesState.initial() = GetImagesInitial;
  const factory GetImagesState.loading() = GetImagesLoading;
  const factory GetImagesState.success(List<PixImage> images) =
      GetImagesSuccess;
  const factory GetImagesState.error(String message) = GetImagesError;
}
