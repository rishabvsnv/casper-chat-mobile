import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/app.dart';

Future<void> bootstrapApp() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);

        debugPrint('Flutter Error: ${details.exceptionAsString()}');
        debugPrintStack(stackTrace: details.stack);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        debugPrint('Platform Error: $error');
        debugPrintStack(stackTrace: stack);

        return true;
      };

      runApp(const ProviderScope(child: MyMessengerApp()));
    },
    (error, stack) {
      debugPrint('❌ Uncaught Error: $error');
      debugPrintStack(stackTrace: stack);
    },
  );
}
