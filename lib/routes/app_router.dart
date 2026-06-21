import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/routes_export.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/chats',
    routes: [
      // Auth
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/otp', builder: (context, state) => const OtpScreen()),

      // Chats
      GoRoute(path: '/chats', builder: (context, state) => const ChatScreen()),

      GoRoute(
        path: '/chats/:chatId',
        builder: (context, state) {
          final chatId = state.pathParameters['chatId']!;

          return MessageInfoScreen(chatId: chatId);
        },
      ),

      // Archive
      GoRoute(
        path: '/archive',
        builder: (context, state) => const ArchivedChatsScreen(),
      ),

      // Profile
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Settings
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/settings/appearance',
        builder: (context, state) => const AppearanceScreen(),
      ),
      GoRoute(
        path: '/settings/language',
        builder: (context, state) => const LanguageScreen(),
      ),
      GoRoute(
        path: '/settings/privacy',
        builder: (context, state) => const PrivacyScreen(),
      ),
      GoRoute(
        path: '/settings/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/settings/storage',
        builder: (context, state) => const StorageScreen(),
      ),
      GoRoute(
        path: '/settings/devices',
        builder: (context, state) => const DevicesScreen(),
      ),
      GoRoute(
        path: '/settings/folders',
        builder: (context, state) => const FoldersScreen(),
      ),

      // Contacts
      GoRoute(
        path: '/contacts',
        builder: (context, state) => const ContactsScreen(),
      ),
      GoRoute(
        path: '/contact/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;

          return ContactProfileScreen(userId: userId);
        },
      ),

      // Calls
      GoRoute(path: '/calls', builder: (context, state) => const CallsScreen()),

      // Saved Messages
      GoRoute(
        path: '/saved-messages',
        builder: (context, state) => const SavedMessagesScreen(),
      ),
      GoRoute(
        path: '/media/:mediaId',
        builder: (context, state) {
          final mediaId = state.pathParameters['mediaId']!;

          return MediaGalleryScreen(mediaId: mediaId);
        },
      ),

      // New Group
      GoRoute(
        path: '/new-group',
        builder: (context, state) => const NewGroupScreen(),
      ),
      GoRoute(
        path: '/group/:groupId',
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;

          return GroupInfoScreen(groupId: groupId);
        },
      ),

      // New Channel
      GoRoute(
        path: '/new-channel',
        builder: (context, state) => const NewChannelScreen(),
      ),
      GoRoute(
        path: '/channel/:channelId',
        builder: (context, state) {
          final channelId = state.pathParameters['channelId']!;

          return ChannelInfoScreen(channelId: channelId);
        },
      ),

      // People Nearby
      GoRoute(
        path: '/people-nearby',
        builder: (context, state) => const PeopleNearbyScreen(),
      ),

      // Notifications
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),

      // Storage Usage
      GoRoute(
        path: '/storage',
        builder: (context, state) => const StorageScreen(),
      ),

      // QR
      GoRoute(
        path: '/my-qr',
        builder: (context, state) => const QrCodeScreen(),
      ),
    ],
  );
});
