import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class SelectChatScreen extends ConsumerStatefulWidget {
  final bool allowMultiSelection;

  const SelectChatScreen({super.key, this.allowMultiSelection = false});

  @override
  ConsumerState<SelectChatScreen> createState() => _SelectChatScreenState();
}

class _SelectChatScreenState extends ConsumerState<SelectChatScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  final Set<String> _selectedChats = {};

  final List<ChatItem> _chats = [
    const ChatItem(
      id: '1',
      title: 'John Doe',
      subtitle: 'Online',
      type: ChatType.private,
    ),
    const ChatItem(
      id: '2',
      title: 'Emma Wilson',
      subtitle: 'Last seen recently',
      type: ChatType.private,
    ),
    const ChatItem(
      id: '3',
      title: 'Flutter Developers',
      subtitle: '284 members',
      type: ChatType.group,
    ),
    const ChatItem(
      id: '4',
      title: 'Work Team',
      subtitle: '56 members',
      type: ChatType.group,
    ),
    const ChatItem(
      id: '5',
      title: 'Technology News',
      subtitle: '12.5K subscribers',
      type: ChatType.channel,
    ),
    const ChatItem(
      id: '6',
      title: 'Design Community',
      subtitle: '3.2K members',
      type: ChatType.group,
    ),
    const ChatItem(
      id: '7',
      title: 'Saved Messages',
      subtitle: 'Personal cloud storage',
      type: ChatType.savedMessages,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ChatItem> get _filteredChats {
    if (_searchQuery.isEmpty) {
      return _chats;
    }

    return _chats.where((chat) {
      return chat.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _onChatTap(ChatItem chat) {
    if (!widget.allowMultiSelection) {
      Navigator.pop(context, chat);
      return;
    }

    setState(() {
      if (_selectedChats.contains(chat.id)) {
        _selectedChats.remove(chat.id);
      } else {
        _selectedChats.add(chat.id);
      }
    });
  }

  void _confirmSelection() {
    final selected = _chats
        .where((chat) => _selectedChats.contains(chat.id))
        .toList();

    Navigator.pop(context, selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.allowMultiSelection ? 'Select Chats' : 'Select Chat',
      ),
      floatingActionButton:
          widget.allowMultiSelection && _selectedChats.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _confirmSelection,
              icon: const Icon(Icons.check),
              label: Text('${_selectedChats.length} Selected'),
            )
          : null,
      body: Column(
        children: [
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

          Expanded(
            child: _filteredChats.isEmpty
                ? const _EmptyChatsView()
                : ListView.separated(
                    itemCount: _filteredChats.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];

                      final selected = _selectedChats.contains(chat.id);

                      return ListTile(
                        leading: Stack(
                          children: [
                            CircleAvatar(child: Icon(_chatIcon(chat.type))),
                            if (selected)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Text(
                          chat.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(chat.subtitle),
                        trailing: widget.allowMultiSelection
                            ? Checkbox(
                                value: selected,
                                onChanged: (_) => _onChatTap(chat),
                              )
                            : const Icon(Icons.chevron_right),
                        onTap: () => _onChatTap(chat),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  IconData _chatIcon(ChatType type) {
    switch (type) {
      case ChatType.private:
        return Icons.person;
      case ChatType.group:
        return Icons.groups;
      case ChatType.channel:
        return Icons.campaign;
      case ChatType.savedMessages:
        return Icons.bookmark;
    }
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
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Chats Found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with a different keyword.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

enum ChatType { private, group, channel, savedMessages }

class ChatItem {
  final String id;
  final String title;
  final String subtitle;
  final ChatType type;

  const ChatItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
  });
}
