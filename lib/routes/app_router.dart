import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/features/common/presentation/screens/main_screen.dart';
import 'package:messenger/features/common/presentation/screens/share_screen.dart';
import 'package:messenger/features/common/presentation/screens/telegram_features_screen.dart';
// import 'package:messenger/features/contacts/presentation/screens/blocked_users_screen.dart';
// import 'package:messenger/features/settings/presentation/screens/active_sessions_screen.dart';
// import 'package:messenger/features/settings/presentation/screens/data_usage_screen.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/routes_export.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: NamedRoutes.chats,

    routes: [
      /// =========================
      /// MAIN SHELL (BOTTOM NAV)
      /// =========================
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen();
        },
        branches: [
          /// CHATS
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: NamedRoutes.chats,
                builder: (_, _) => const ChatScreen(),
                routes: [
                  GoRoute(
                    path: ':chatId',
                    builder: (context, state) {
                      return MessageInfoScreen(
                        chatId: state.pathParameters['chatId']!,
                        userName: state.extra as String,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          /// CONTACTS
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: NamedRoutes.contacts,
                builder: (_, _) => const ContactsScreen(),
              ),
            ],
          ),

          /// SETTINGS
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: NamedRoutes.settings,
                builder: (_, _) => const SettingScreen(),
                routes: [
                  GoRoute(
                    path: 'appearance',
                    builder: (_, _) => const AppearanceScreen(),
                  ),
                  GoRoute(
                    path: 'privacy',
                    builder: (_, _) => const PrivacyScreen(),
                  ),
                  GoRoute(
                    path: 'language',
                    builder: (_, _) => const LanguageScreen(),
                  ),
                ],
              ),
            ],
          ),

          /// PROFILE
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: NamedRoutes.profile,
                builder: (_, _) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      /// =========================
      /// AUTH (OUTSIDE SHELL)
      /// =========================
      GoRoute(
        path: NamedRoutes.splash,
        builder: (_, _) => const SplashScreen(),
      ),

      GoRoute(path: NamedRoutes.login, builder: (_, _) => const LoginScreen()),

      GoRoute(path: NamedRoutes.otp, builder: (_, _) => const OtpScreen()),

      /// =========================
      /// FULL SCREEN OVERLAYS
      /// =========================
      GoRoute(
        path: NamedRoutes.peopleNearby,
        builder: (_, _) => const PeopleNearbyScreen(),
      ),

      GoRoute(
        path: NamedRoutes.newGroup,
        builder: (_, _) => const NewGroupScreen(),
      ),

      GoRoute(
        path: NamedRoutes.newChannel,
        builder: (_, _) => const NewChannelScreen(),
      ),

      GoRoute(
        path: NamedRoutes.savedMessages,
        builder: (_, _) => const SavedMessagesScreen(),
      ),

      GoRoute(
        path: NamedRoutes.telegramFeatures,
        builder: (_, _) => const TelegramFeaturesScreen(),
      ),

      GoRoute(path: NamedRoutes.share, builder: (_, _) => const ShareScreen()),
    ],
  );
});
