/* import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myschoolio/core/config/session_config.dart';
import 'package:myschoolio/providers/session_provider.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
  final WidgetRef ref;

  AppLifecycleHandler(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) return;

    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;
    final lastActive = prefs.getInt(lastActiveKey);

    if (lastActive != null) {
      final diff = Duration(milliseconds: now - lastActive);

      if (diff >= sessionCutoff) {
        // 🔥 New session → refresh permissions
        ref.read(sessionProvider.notifier).state++;
      }
    }

    await prefs.setInt(lastActiveKey, now);
  }
}
 */