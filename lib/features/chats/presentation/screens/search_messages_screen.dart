import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class SearchMessagesScreen extends ConsumerStatefulWidget {
  const SearchMessagesScreen({super.key});

  @override
  ConsumerState<SearchMessagesScreen> createState() =>
      _SearchMessagesScreenState();
}

class _SearchMessagesScreenState extends ConsumerState<SearchMessagesScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<MessageSearchResult> _messages = [
    const MessageSearchResult(
      id: '1',
      sender: 'John Doe',
      message: 'Flutter Riverpod is a powerful state management solution.',
      date: 'Today, 10:24 AM',
      chatName: 'Flutter Developers',
    ),
    const MessageSearchResult(
      id: '2',
      sender: 'Emma Wilson',
      message: 'Please review the architecture document before tomorrow.',
      date: 'Yesterday',
      chatName: 'Work Group',
    ),
    const MessageSearchResult(
      id: '3',
      sender: 'Michael Smith',
      message: 'The latest Telegram clone update has been deployed.',
      date: 'Monday',
      chatName: 'Development Team',
    ),
    const MessageSearchResult(
      id: '4',
      sender: 'Sophia Brown',
      message: 'Meeting is scheduled for Friday at 5 PM.',
      date: 'Jun 15',
      chatName: 'Project Discussion',
    ),
  ];

  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMessages = _messages.where((message) {
      if (_query.isEmpty) return true;

      return message.message.toLowerCase().contains(_query.toLowerCase()) ||
          message.sender.toLowerCase().contains(_query.toLowerCase()) ||
          message.chatName.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Search Messages'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();

                          setState(() {
                            _query = '';
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),

          if (_query.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${filteredMessages.length} result(s)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),

          const SizedBox(height: 8),

          Expanded(
            child: filteredMessages.isEmpty
                ? _EmptySearchState(hasQuery: _query.isNotEmpty)
                : ListView.separated(
                    itemCount: filteredMessages.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final message = filteredMessages[index];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(message.sender[0].toUpperCase()),
                        ),
                        title: Text(
                          message.sender,
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
                              '${message.chatName} • ${message.date}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        onTap: () {
                          // Todo:
                          // Jump to original message
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

class _EmptySearchState extends StatelessWidget {
  final bool hasQuery;

  const _EmptySearchState({required this.hasQuery});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),

            const SizedBox(height: 16),

            Text(
              hasQuery ? 'No Results Found' : 'Search Messages',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(
              hasQuery
                  ? 'Try another keyword.'
                  : 'Search messages, users, and chats.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class MessageSearchResult {
  final String id;
  final String sender;
  final String message;
  final String date;
  final String chatName;

  const MessageSearchResult({
    required this.id,
    required this.sender,
    required this.message,
    required this.date,
    required this.chatName,
  });
}
