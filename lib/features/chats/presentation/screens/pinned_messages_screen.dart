import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class PinnedMessagesScreen extends ConsumerWidget {
  const PinnedMessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinnedMessages = [
      const PinnedMessage(
        id: '1',
        senderName: 'John Doe',
        message:
            'Please review the latest Flutter architecture document before tomorrow.',
        time: '10:24 AM',
        isPinnedByAdmin: true,
      ),
      const PinnedMessage(
        id: '2',
        senderName: 'Emma Wilson',
        message: 'Meeting scheduled for Friday at 5 PM. Everyone should join.',
        time: 'Yesterday',
        isPinnedByAdmin: false,
      ),
      const PinnedMessage(
        id: '3',
        senderName: 'Michael Smith',
        message: 'New application release is now available for testing.',
        time: 'Monday',
        isPinnedByAdmin: true,
      ),
      const PinnedMessage(
        id: '4',
        senderName: 'Sophia Brown',
        message: 'Important channel guidelines have been updated.',
        time: 'Jun 15',
        isPinnedByAdmin: false,
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Pinned Messages'),
      body: pinnedMessages.isEmpty
          ? const _EmptyPinnedMessagesView()
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Row(
                    children: [
                      const Icon(Icons.push_pin_outlined),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${pinnedMessages.length} pinned messages',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.separated(
                    itemCount: pinnedMessages.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final message = pinnedMessages[index];

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          child: Text(message.senderName[0].toUpperCase()),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                message.senderName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (message.isPinnedByAdmin)
                              const Icon(
                                Icons.admin_panel_settings_outlined,
                                size: 18,
                              ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              message.message,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              message.time,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (_) => const [
                            PopupMenuItem(
                              value: 'jump',
                              child: Text('Go to Message'),
                            ),
                            PopupMenuItem(
                              value: 'copy',
                              child: Text('Copy Text'),
                            ),
                            PopupMenuItem(
                              value: 'unpin',
                              child: Text('Unpin Message'),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Todo:
                          // Navigate to original message
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _EmptyPinnedMessagesView extends StatelessWidget {
  const _EmptyPinnedMessagesView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.push_pin_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Pinned Messages',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Pinned messages will appear here for quick access.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class PinnedMessage {
  final String id;
  final String senderName;
  final String message;
  final String time;
  final bool isPinnedByAdmin;

  const PinnedMessage({
    required this.id,
    required this.senderName,
    required this.message,
    required this.time,
    required this.isPinnedByAdmin,
  });
}
