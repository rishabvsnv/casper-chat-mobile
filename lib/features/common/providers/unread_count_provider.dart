import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/features/chats/providers/chat_provider.dart';

final unreadCountProvider = Provider<int>((ref) {
  final chats = ref.watch(chatsProvider);

  return chats.where((chat) => (chat['unread'] as int) > 0).length;
});
/* final unreadCountProvider = Provider<int>((ref) {
  final chats = ref.watch(chatsProvider);

  for (final chat in chats) {
    debugPrint('${chat["name"]}: ${chat["unread"]}');
  }

  final total = chats.fold<int>(
    0,
    (sum, chat) => sum + ((chat["unread"] as int?) ?? 0),
  );

  debugPrint('Total unread: $total');

  return total;
}); */
