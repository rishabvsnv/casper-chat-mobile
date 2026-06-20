import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/core/constants/app_constants.dart';
import 'package:messenger/core/theme/app_theme.dart';
import 'package:messenger/routes/app_router.dart';

class MyMessengerApp extends ConsumerWidget {
  const MyMessengerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
