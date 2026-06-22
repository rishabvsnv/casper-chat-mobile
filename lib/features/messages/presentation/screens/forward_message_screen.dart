import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ForwardMessageScreen extends ConsumerStatefulWidget {
  const ForwardMessageScreen({super.key});

  @override
  ConsumerState<ForwardMessageScreen> createState() =>
      _ForwardMessageScreenState();
}

class _ForwardMessageScreenState extends ConsumerState<ForwardMessageScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  final Set<String> _selectedChats = {};

  final List<ChatModel> _chats = [
    const ChatModel(
      id: '1',
      title: 'John Doe',
      subtitle: 'Online',
      isGroup: false,
    ),
    const ChatModel(
      id: '2',
      title: 'Flutter Developers',
      subtitle: '284 members',
      isGroup: true,
    ),
    const ChatModel(
      id: '3',
      title: 'Emma Wilson',
      subtitle: 'Last seen recently',
      isGroup: false,
    ),
    const ChatModel(
      id: '4',
      title: 'Work Team',
      subtitle: '56 members',
      isGroup: true,
    ),
    const ChatModel(
      id: '5',
      title: 'Design Team',
      subtitle: '23 members',
      isGroup: true,
    ),
    const ChatModel(
      id: '6',
      title: 'Michael Smith',
      subtitle: 'Online',
      isGroup: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _forwardMessages() {
    if (_selectedChats.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Select at least one chat')));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message forwarded to ${_selectedChats.length} chat(s)'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final filteredChats = _chats.where((chat) {
      if (_searchQuery.isEmpty) {
        return true;
      }

      return chat.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Forward Message'),
      floatingActionButton: _selectedChats.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _forwardMessages,
              icon: const Icon(Icons.send),
              label: Text('Forward (${_selectedChats.length})'),
            ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forwarding Message',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6),
                Text(
                  'Select chats, groups, or channels to forward this message.',
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search chats',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();

                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          if (_selectedChats.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Text(
                '${_selectedChats.length} selected',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

          Expanded(
            child: filteredChats.isEmpty
                ? const _EmptyChatsView()
                : ListView.separated(
                    itemCount: filteredChats.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];

                      final selected = _selectedChats.contains(chat.id);

                      return CheckboxListTile(
                        value: selected,
                        secondary: CircleAvatar(
                          child: Icon(
                            chat.isGroup ? Icons.groups : Icons.person,
                          ),
                        ),
                        title: Text(
                          chat.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(chat.subtitle),
                        onChanged: (value) {
                          setState(() {
                            if (value ?? false) {
                              _selectedChats.add(chat.id);
                            } else {
                              _selectedChats.remove(chat.id);
                            }
                          });
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

class _EmptyChatsView extends StatelessWidget {
  const _EmptyChatsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.forward_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No Chats Found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching for another chat.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatModel {
  final String id;
  final String title;
  final String subtitle;
  final bool isGroup;

  const ChatModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isGroup,
  });
}
