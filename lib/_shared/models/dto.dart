import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

@freezed
abstract class ProfileDataDto with _$ProfileDataDto {
  factory ProfileDataDto({
    required String fullName,
    required String email,
    required String favoriteCategory,
    required String password,
  }) = _ProfileDataDto;

  factory ProfileDataDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataDtoFromJson(json);
}
