import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class CallHistoryScreen extends ConsumerWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calls = [
      const CallHistoryItem(
        name: 'John Doe',
        date: 'Today, 10:24 AM',
        isIncoming: true,
        isMissed: false,
        isVideo: false,
      ),
      const CallHistoryItem(
        name: 'Emma Wilson',
        date: 'Today, 08:12 AM',
        isIncoming: false,
        isMissed: false,
        isVideo: true,
      ),
      const CallHistoryItem(
        name: 'Alex Johnson',
        date: 'Yesterday, 09:41 PM',
        isIncoming: true,
        isMissed: true,
        isVideo: false,
      ),
      const CallHistoryItem(
        name: 'Sophia Brown',
        date: 'Yesterday, 05:10 PM',
        isIncoming: false,
        isMissed: false,
        isVideo: false,
      ),
      const CallHistoryItem(
        name: 'Flutter Community',
        date: 'Monday, 02:15 PM',
        isIncoming: true,
        isMissed: false,
        isVideo: true,
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Call History'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo:
          // Start new call
        },
        child: const Icon(Icons.add_call),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Row(
              children: [
                Icon(Icons.history),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'View and manage your voice and video call history.',
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: calls.isEmpty
                ? const _EmptyCallHistory()
                : ListView.separated(
                    itemCount: calls.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final call = calls[index];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(call.name[0].toUpperCase()),
                        ),
                        title: Text(
                          call.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: call.isMissed ? Colors.red : null,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(
                              call.isIncoming
                                  ? Icons.call_received
                                  : Icons.call_made,
                              size: 16,
                              color: call.isMissed ? Colors.red : Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                call.date,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            call.isVideo ? Icons.videocam : Icons.call,
                          ),
                          onPressed: () {
                            // Todo:
                            // Start call again
                          },
                        ),
                        onTap: () {
                          // Todo:
                          // Open call details
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

class _EmptyCallHistory extends StatelessWidget {
  const _EmptyCallHistory();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.call_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No Call History',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Your completed, missed, and outgoing calls will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class CallHistoryItem {
  final String name;
  final String date;
  final bool isIncoming;
  final bool isMissed;
  final bool isVideo;

  const CallHistoryItem({
    required this.name,
    required this.date,
    required this.isIncoming,
    required this.isMissed,
    required this.isVideo,
  });
}
