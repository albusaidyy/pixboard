import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pixboard/utils/_index.dart';

class NetworkUtil {
  factory NetworkUtil() => _networkUtil;

  NetworkUtil.internal();

  final _logger = Logger();

  static final NetworkUtil _networkUtil = NetworkUtil.internal();

  Future<Map<String, dynamic>> getData({required String query}) async {
    try {
      final dio = Dio();

      final apiUrl =
          '${PixBoardConfig.instance!.values.urlScheme}://${PixBoardConfig.instance!.values.baseDomain}';

      final response = await dio.get<dynamic>(
        apiUrl,
        queryParameters: {
          'key': PixBoardConfig.instance!.values.apiKey,
          'q': query,
        },
      );

      final responseBody = response.data as Map<String, dynamic>;
      if (responseBody.isEmpty) return <String, dynamic>{};
      return responseBody;
    } on DioException catch (err) {
      if (DioExceptionType.badResponse == err.type) {
        _logger
          ..d('Error: $err')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');

        if (err.response?.statusCode == 422) {
          throw Exception('Validation failed');
        }

        if (err.response?.statusCode == 403) {
          throw Exception(err.response!.statusMessage);
        }

        if (err.response?.statusCode == 401) {
          throw Exception('Unauthenticated');
        }
      } else if (DioExceptionType.connectionTimeout == err.type) {
        throw Exception('No internet connection');
      }
      throw Exception('Server error');
    }
  }

  Future<Map<String, dynamic>> postData({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await Dio().post<Map<String, dynamic>>(
        'https://jsonplaceholder.typicode.com/posts',
        data: data,
      );
      final responseBody = response.data ?? <String, dynamic>{};
      if (responseBody.isEmpty) return <String, dynamic>{};
      return responseBody;
    } on DioException catch (err) {
      if (DioExceptionType.badResponse == err.type) {
        _logger
          ..d('Error: $err')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');

        if (err.response?.statusCode == 422) {
          throw Exception('Validation failed');
        }

        if (err.response?.statusCode == 403) {
          throw Exception(err.response!.statusMessage);
        }

        if (err.response?.statusCode == 401) {
          throw Exception('Unauthenticated');
        }
      } else if (DioExceptionType.connectionTimeout == err.type) {
        throw Exception('No internet connection');
      }
      throw Exception('Server error');
    }
  }
}
