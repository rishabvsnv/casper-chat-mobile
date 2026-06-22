import 'package:flutter/material.dart';
import 'package:messenger/features/settings/domain/chat_folder.dart';

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
        onPressed: () async {
          final controller = TextEditingController();

          final result = await showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('New Folder'),
                content: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Folder name',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () {
                      final name = controller.text.trim();

                      if (name.isEmpty) {
                        return;
                      }

                      Navigator.pop(context, name);
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            },
          );

          if (result == null || result.isEmpty) {
            return;
          }

          setState(() {
            folders.add(
              ChatFolder(
                title: result,
                description: 'Custom folder',
                icon: Icons.folder_outlined,
              ),
            );
          });

          ScaffoldMessenger.of(
            // ignore: use_build_context_synchronously
            context,
          ).showSnackBar(SnackBar(content: Text('$result folder created')));
        },
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
                  onLongPress: folder.isDefault
                      ? null
                      : () {
                          _showFolderActions(folder, index);
                        },
                  trailing: folder.isDefault
                      ? const Chip(label: Text('Default'))
                      : ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.drag_handle),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showFolderActions(ChatFolder folder, int index) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Rename Folder'),
                onTap: () {
                  Navigator.pop(context);
                  _renameFolder(folder, index);
                },
              ),

              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Delete Folder'),
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    folders.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${folder.title} deleted')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _renameFolder(ChatFolder folder, int index) async {
    final controller = TextEditingController(text: folder.title);

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Folder'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == null || result.isEmpty) {
      return;
    }

    setState(() {
      folders[index] = ChatFolder(
        title: result,
        description: folder.description,
        icon: folder.icon,
        isDefault: folder.isDefault,
      );
    });
  }
}
