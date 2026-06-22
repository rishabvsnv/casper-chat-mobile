import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class FoldersScreen extends ConsumerStatefulWidget {
  const FoldersScreen({super.key});

  @override
  ConsumerState<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends ConsumerState<FoldersScreen> {
  final List<FolderItem> _folders = [
    const FolderItem(
      name: 'All Chats',
      icon: Icons.chat_bubble_outline,
      description: 'All messages',
      isDefault: true,
    ),
    const FolderItem(
      name: 'Unread',
      icon: Icons.mark_chat_unread_outlined,
      description: 'Unread conversations',
      isDefault: true,
    ),
    const FolderItem(
      name: 'Personal',
      icon: Icons.person_outline,
      description: 'Friends and family',
    ),
    const FolderItem(
      name: 'Work',
      icon: Icons.work_outline,
      description: 'Work chats',
    ),
    const FolderItem(
      name: 'Groups',
      icon: Icons.groups_outlined,
      description: 'Group conversations',
    ),
    const FolderItem(
      name: 'Channels',
      icon: Icons.campaign_outlined,
      description: 'Subscribed channels',
    ),
  ];

  Future<void> _createFolder() async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Create Folder'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Folder name',
              border: OutlineInputBorder(),
            ),
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
                final value = controller.text.trim();

                if (value.isEmpty) {
                  return;
                }

                Navigator.pop(context, value);
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
      _folders.add(
        FolderItem(
          name: result,
          icon: Icons.folder_outlined,
          description: 'Custom folder',
        ),
      );
    });

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$result created')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Chat Folders'),
      floatingActionButton: FloatingActionButton(
        onPressed: _createFolder,
        child: const Icon(Icons.create_new_folder_outlined),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Text(
              'Organize chats into custom folders. '
              'Folders appear as tabs on your chat list.',
            ),
          ),

          Expanded(
            child: _folders.isEmpty
                ? const _EmptyFoldersView()
                : ReorderableListView.builder(
                    itemCount: _folders.length,
                    buildDefaultDragHandles: false,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }

                        final item = _folders.removeAt(oldIndex);

                        _folders.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (context, index) {
                      final folder = _folders[index];

                      return ListTile(
                        key: ValueKey(folder.name),
                        leading: CircleAvatar(child: Icon(folder.icon)),
                        title: Text(
                          folder.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(folder.description),
                        trailing: folder.isDefault
                            ? const Chip(label: Text('Default'))
                            : ReorderableDragStartListener(
                                index: index,
                                child: const Icon(Icons.drag_handle),
                              ),
                        onTap: () {
                          context.push('/edit-folder');
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

class _EmptyFoldersView extends StatelessWidget {
  const _EmptyFoldersView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text('No Folders', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Create folders to organize your chats.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class FolderItem {
  final String name;
  final String description;
  final IconData icon;
  final bool isDefault;

  const FolderItem({
    required this.name,
    required this.description,
    required this.icon,
    this.isDefault = false,
  });
}
