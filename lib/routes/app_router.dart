import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/auth_routes.dart';
import 'package:messenger/routes/call_routes.dart';
import 'package:messenger/routes/channel_routes.dart';
import 'package:messenger/routes/chat_routes.dart';
import 'package:messenger/routes/common_routes.dart';
import 'package:messenger/routes/contact_router.dart';
import 'package:messenger/routes/folder_routes.dart';
import 'package:messenger/routes/group_routes.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/settings_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: NamedRoutes.splash,

    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;

      final isLoggedIn = session != null;
      final isAuthRoute =
          state.matchedLocation == NamedRoutes.login ||
          state.matchedLocation == NamedRoutes.otp ||
          state.matchedLocation == NamedRoutes.emailVerification;

      if (!isLoggedIn && !isAuthRoute) {
        return NamedRoutes.login;
      }

      if (isLoggedIn && isAuthRoute) {
        return NamedRoutes.main;
      }

      return null;
    },

    routes: [
      ...authRoutes,
      ...commonRoutes,
      ...chatRoutes,
      ...contactRoutes,
      ...callRoutes,
      ...settingsRoutes,
      ...folderRoutes,
      ...groupRoutes,
      ...channelRoutes,
    ],
  );
});
