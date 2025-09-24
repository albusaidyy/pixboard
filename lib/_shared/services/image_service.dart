import 'dart:io';

import 'package:pixboard/_shared/models/image_model.dart';
import 'package:pixboard/utils/_index.dart';

abstract class ImageService {
  Future<List<PixImage>> getImages(String query);
  Future<PixImage> getImage(String id);
}

class ImageServiceImpl implements ImageService {
  final _networkUtil = NetworkUtil();

  @override
  Future<List<PixImage>> getImages(String query) async {
    try {
      final response = await _networkUtil.getData(query: query);
      return response['hits'] as List<PixImage>;
    } on SocketException catch (e) {
      throw Exception(e);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PixImage> getImage(String id) async {
    try {
      final response = await _networkUtil.getData(query: id);
      return PixImage.fromJson(response);
    } on SocketException catch (e) {
      throw Exception(e);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
