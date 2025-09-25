import 'dart:io';

import 'package:pixboard/_shared/models/dto.dart';
import 'package:pixboard/utils/_index.dart';

abstract class ProfileService {
  Future<int> submitProfile({required ProfileDataDto data});
}

class ProfileServiceImpl implements ProfileService {
  final _networkUtil = NetworkUtil();

  @override
  Future<int> submitProfile({
    required ProfileDataDto data,
  }) async {
    try {
      final response = await _networkUtil.postData(data: data.toJson());
      final postId = response['id'] as int? ?? 0;
      return postId;
    } on SocketException {
      throw Exception('Check network connection!');
    } on Exception catch (_) {
      rethrow;
    }
  }
}
