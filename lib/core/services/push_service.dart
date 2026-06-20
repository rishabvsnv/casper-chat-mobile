/* import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myschoolio/providers/permission_provider.dart';

final pushServiceProvider = Provider<PushService>((ref) {
  return PushService(ref);
});

class PushService {
  final Ref ref;
  bool _initialized = false;

  PushService(this.ref);

  Future<void> init() async {
    if (kIsWeb || _initialized) return;

    _initialized = true;

    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _handleMessage(RemoteMessage message) {
    if (kDebugMode) {
      debugPrint('📩 FCM message: ${message.data}');
    }

    if (message.data['type'] == 'PERMISSION_UPDATED') {
      debugPrint('🔄 Permission updated via FCM, refreshing provider');
      ref.read(permissionProvider.notifier).refresh();
    }
  }
}
 */
