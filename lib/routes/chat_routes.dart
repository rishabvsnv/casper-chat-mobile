import 'package:messenger/routes/routes_export.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final chatRoutes = <RouteBase>[
  appRoute(NamedRoutes.chats, (_, _) => const ChatScreen()),

  appRoute(NamedRoutes.chatWithParams, (context, state) {
    final chatId = state.pathParameters['chatId']!;
    final userName = state.extra as String;
    return MessageInfoScreen(chatId: chatId, userName: userName);
  }),

  appRoute(NamedRoutes.savedMessages, (_, _) => const SavedMessagesScreen()),

  appRoute(NamedRoutes.mediaWithParams, (context, state) {
    final mediaId = state.pathParameters['mediaId']!;
    return MediaGalleryScreen(mediaId: mediaId);
  }),
];
