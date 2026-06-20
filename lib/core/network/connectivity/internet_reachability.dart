/* import 'package:dio/dio.dart';
import 'package:myschoolio/core/network/connectivity/network_status.dart';

class InternetReachability {
  final Dio _dio;

  InternetReachability(this._dio);

  Future<NetworkStatus> check() async {
    try {
      final response = await _dio.get(
        'https://www.google.com/generate_204',
        options: Options(receiveTimeout: const Duration(seconds: 3)),
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return NetworkStatus.connected;
      }

      return NetworkStatus.disconnected;
    } catch (_) {
      return NetworkStatus.disconnected;
    }
  }
}
 */
