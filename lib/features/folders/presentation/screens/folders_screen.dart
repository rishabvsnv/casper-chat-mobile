import 'package:flutter/material.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<ChatFolder> folders = [
    const ChatFolder(
      title: 'All Chats',
      icon: Icons.chat_bubble_outline,
      description: 'All messages',
      isDefault: true,
    ),
    const ChatFolder(
      title: 'Unread',
      icon: Icons.mark_chat_unread_outlined,
      description: 'Unread conversations',
    ),
    const ChatFolder(
      title: 'Personal',
      icon: Icons.person_outline,
      description: 'Friends and family',
    ),
    const ChatFolder(
      title: 'Work',
      icon: Icons.work_outline,
      description: 'Work related chats',
    ),
    const ChatFolder(
      title: 'Groups',
      icon: Icons.groups_outlined,
      description: 'Group conversations',
    ),
    const ChatFolder(
      title: 'Channels',
      icon: Icons.campaign_outlined,
      description: 'Subscribed channels',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Folders')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.create_new_folder_outlined),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Text(
              'Organize your chats into custom folders. '
              'Folders appear as tabs on the chat list.',
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              itemCount: folders.length,

              onReorderItem: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = folders.removeAt(oldIndex);
                  folders.insert(newIndex, item);
                });
              },

              itemBuilder: (context, index) {
                final folder = folders[index];

                return ListTile(
                  key: ValueKey(folder.title),
                  leading: CircleAvatar(child: Icon(folder.icon)),
                  title: Text(
                    folder.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(folder.description),
                  trailing: folder.isDefault
                      ? const Chip(label: Text('Default'))
                      : const Icon(Icons.drag_handle),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatFolder {
  final String title;
  final String description;
  final IconData icon;
  final bool isDefault;

  const ChatFolder({
    required this.title,
    required this.description,
    required this.icon,
    this.isDefault = false,
  });
}
