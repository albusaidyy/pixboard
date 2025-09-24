import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:pixboard/utils/_index.dart';

class NetworkUtil {
  factory NetworkUtil() => _networkUtil;

  NetworkUtil.internal();

  final _logger = Logger();

  static final NetworkUtil _networkUtil = NetworkUtil.internal();

  Future<Map<String, dynamic>> getData({required String query}) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl:
              '${PixBoardConfig.instance!.values.urlScheme}://${PixBoardConfig.instance!.values.baseDomain}',
          contentType: 'application/json',
          // headers: <String, dynamic>{
          //   'Accept': 'application/json',
          // },
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

      final response = await dio.get<dynamic>(
        '/',
        data: {
          'key': dotenv.env['PIXABAY_API_KEY'],
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
}
