import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.g.dart';
part 'image_model.freezed.dart';

@freezed
abstract class PixImage with _$PixImage {
  factory PixImage({
    required String id,
    required String pageURL,
    required String type,
    required String tags,
    required String previewURL,
    required String previewWidth,
    required String previewHeight,
    required String webformatURL,
    required String webformatWidth,
    required String webformatHeight,
    required String largeImageURL,
    required String fullHDURL,
    required String imageURL,
    required String imageWidth,
    required String imageHeight,
    required String imageSize,
    required String views,
    required String downloads,
    required String likes,
    required String comments,
    @JsonKey(name: 'user_id') required String userId,
    required String user,
    required String userImageURL,
  }) = _PixImage;

  factory PixImage.fromJson(Map<String, dynamic> json) =>
      _$PixImageFromJson(json);
}
