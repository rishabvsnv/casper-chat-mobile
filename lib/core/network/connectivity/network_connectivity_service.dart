/* import 'package:dio/dio.dart';
import 'package:myschoolio/core/network/dio_client.dart';

class NetworkConnectivityService {
  final Dio _dio = DioClient.dio;

  Future<bool> hasConnection() async {
    try {
      final response = await _dio.get(
        'https://www.google.com/generate_204',
        options: Options(receiveTimeout: const Duration(seconds: 3)),
      );

      return response.statusCode == 204 || response.statusCode == 200;
    } on DioException {
      return false;
    }
  }
}
 */