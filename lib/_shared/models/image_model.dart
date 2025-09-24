import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.g.dart';
part 'image_model.freezed.dart';

@freezed
abstract class PixImage with _$PixImage {
  factory PixImage({
    required int id,
    @Default('') String pageURL,
    @Default('') String type,
    @Default('') String tags,
    @Default('') String previewURL,
    @Default(0) int previewWidth,
    @Default(0) int previewHeight,
    @Default('') String webformatURL,
    @Default(0) int webformatWidth,
    @Default(0) int webformatHeight,
    @Default('') String largeImageURL,
    @Default('') String fullHDURL,
    @Default(0) int imageWidth,
    @Default(0) int imageHeight,
    @Default(0) int imageSize,
    @Default(0) int views,
    @Default(0) int downloads,
    @Default(0) int likes,
    @Default(0) int comments,
    @JsonKey(name: 'user_id') @Default(0) int userId,
    @Default('') String user,
    @Default('') String userImageURL,
  }) = _PixImage;

  factory PixImage.fromJson(Map<String, dynamic> json) =>
      _$PixImageFromJson(json);
}
