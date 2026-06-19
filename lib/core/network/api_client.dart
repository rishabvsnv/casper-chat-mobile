/* import 'package:myschoolio/core/config/api_config.dart';

class ApiClient {
  // static const String baseUrl = 'https://myschoolio.com/api';
  static const String _apiPrefix = '/api';

  static Map<String, String> headers({String? token}) => {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  static Uri uri(String path, [Map<String, dynamic>? query]) {
    return Uri.parse(
      '${ApiConfig.baseUrl}$_apiPrefix$path',
    ).replace(queryParameters: query);
  }
}
 */