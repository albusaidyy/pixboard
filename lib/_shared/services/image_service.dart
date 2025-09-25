import 'dart:io';

import 'package:pixboard/_shared/models/image_model.dart';
import 'package:pixboard/utils/_index.dart';

abstract class ImageService {
  Future<List<PixImage>> getImages(String query);
}

class ImageServiceImpl implements ImageService {
  final _networkUtil = NetworkUtil();

  @override
  Future<List<PixImage>> getImages(String query) async {
    try {
      final response = await _networkUtil.getData(query: query);
      final images = (response['hits'] as List)
          .map((e) => PixImage.fromJson(e as Map<String, dynamic>))
          .toList();
      return images;
    } on SocketException {
      throw Exception('Check network connection!');
    } on Exception catch (_) {
      rethrow;
    }
  }
}
