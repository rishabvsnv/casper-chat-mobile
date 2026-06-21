import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/features/chats/domain/chat_model.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ArchivedChatsScreen extends ConsumerWidget {
  const ArchivedChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = [
      ChatModel(
        name: 'Roberto',
        message: 'Say hello to Emma.',
        time: '9:41',
        unread: 1,
        color: Colors.green,
        read: false,
        muted: false,
        pinned: false,
      ),
      ChatModel(
        name: '8Bit Times',
        message: '8Bit Times started a Live Stream',
        time: '9:41',
        unread: 4,
        color: Colors.red,
        read: false,
        muted: true,
        pinned: false,
      ),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.mode_edit_outline_rounded),
      ),
      appBar: CustomAppBar(
        title: 'Archived (${chats.length})',
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton<String>(
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'settings', child: Text('Archive Settings')),
              PopupMenuItem(value: 'read_all', child: Text('Mark All Read')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: chats.isEmpty
            ? const _EmptyArchiveView()
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.archive_outlined),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Archived chats stay hidden when new messages arrive.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.separated(
                      itemCount: chats.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final chat = chats[index];

                        return Dismissible(
                          key: ValueKey(chat.name),
                          background: Container(
                            color: Colors.green,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: const Icon(
                              Icons.unarchive,
                              color: Colors.white,
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Chat unarchived'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Chat deleted')),
                              );
                            }

                            return false;
                          },
                          child: InkWell(
                            onTap: () {
                              context.push('/chats/$index');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: chat.color,
                                    child: Text(
                                      chat.name.substring(0, 1).toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                chat.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),

                                            if (chat.pinned)
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Icon(
                                                  Icons.push_pin_rounded,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),

                                            Text(
                                              chat.time,
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 4),

                                        Row(
                                          children: [
                                            Icon(
                                              chat.read
                                                  ? Icons.done_all
                                                  : Icons.done,
                                              size: 16,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),

                                            const SizedBox(width: 4),

                                            Expanded(
                                              child: Text(
                                                chat.message,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ),

                                            if (chat.muted)
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  left: 6,
                                                ),
                                                child: Icon(
                                                  Icons.volume_off_outlined,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  if (chat.unread > 0)
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        chat.unread.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _EmptyArchiveView extends StatelessWidget {
  const _EmptyArchiveView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.archive_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No Archived Chats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Chats you archive will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
