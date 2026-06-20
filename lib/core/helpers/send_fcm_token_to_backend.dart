/* import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myschoolio/core/config/api_config.dart';
import 'package:myschoolio/core/helpers/auth_helper.dart';

Future<void> sendFcmTokenToBackend({String? role, bool clear = false}) async {
  if (kIsWeb) return;

  final jwt = AuthHelper.getToken();
  if (jwt == null) {
    debugPrint('❌ FCM: JWT is null');
    return;
  }

  final prefs = await SharedPreferences.getInstance();

  if (clear) {
    await prefs.remove('last_fcm_token');
    debugPrint('🧹 FCM: Cleared stored token');
    return;
  }

  final token = await FirebaseMessaging.instance.getToken();
  if (token == null) {
    debugPrint('❌ FCM: Token is null');
    return;
  }

  debugPrint('🔑 FCM: Got token: ${token.substring(0, 10)}...');

  final lastToken = prefs.getString('last_fcm_token');

  if (lastToken == token) {
    if (kDebugMode) {
      debugPrint('📴 FCM token unchanged');
    }
    return;
  }

  if (role == null) {
    debugPrint('❌ FCM: Role is null');
    return;
  }

  final endpoint = '${ApiConfig.baseUrl}/api/teachers/save-fcm-token';

  if (kDebugMode) {
    debugPrint('📲 Sending FCM token to $endpoint');
  }

  final response = await http.post(
    Uri.parse(endpoint),
    headers: {'Authorization': 'Bearer $jwt'},
    body: {'fcm_token': token},
  );

  if (response.statusCode == 200) {
    await prefs.setString('last_fcm_token', token);
    debugPrint('✅ FCM: Token sent successfully');
  } else {
    debugPrint('❌ FCM: Failed to send token, status: ${response.statusCode}, body: ${response.body}');
  }
}
 */
