import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
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
      icon: Icons.chat_bubble_outline_rounded,
      description: 'All messages',
      chatCount: 248,
      isDefault: true,
    ),
    const FolderItem(
      name: 'Unread',
      icon: Icons.mark_chat_unread_outlined,
      description: 'Unread conversations',
      chatCount: 17,
      isDefault: true,
    ),
    const FolderItem(
      name: 'Personal',
      icon: Icons.person_outline_rounded,
      description: 'Friends & Family',
      chatCount: 32,
    ),
    const FolderItem(
      name: 'Work',
      icon: Icons.work_outline_rounded,
      description: 'Work related chats',
      chatCount: 48,
    ),
    const FolderItem(
      name: 'Groups',
      icon: Icons.groups_outlined,
      description: 'Group conversations',
      chatCount: 24,
    ),
    const FolderItem(
      name: 'Channels',
      icon: Icons.campaign_outlined,
      description: 'Subscribed channels',
      chatCount: 116,
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
            decoration: const InputDecoration(hintText: 'Folder name'),
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

                if (value.isEmpty) return;

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
          description: 'Custom folder',
          icon: Icons.folder_outlined,
          chatCount: 0,
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
    final theme = Theme.of(context);

    final customFolders = _folders.where((e) => !e.isDefault).length;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Chat Folders'),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createFolder,
        icon: const Icon(Icons.add),
        label: const Text('New Folder'),
      ),

      body: ListView(
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          const SizedBox(height: 12),

          // Summary Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Icon(
                        Icons.folder_copy_outlined,
                        color: theme.colorScheme.primary,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Chat Folders',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_folders.length} folders configured',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: '${_folders.length}',
                    subtitle: 'Folders',
                    icon: Icons.folder_outlined,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _StatCard(
                    title: '$customFolders',
                    subtitle: 'Custom',
                    icon: Icons.edit_outlined,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _StatCard(
                    title: '${_folders.where((e) => e.isDefault).length}',
                    subtitle: 'Default',
                    icon: Icons.star_outline,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Your Folders',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          if (_folders.isEmpty)
            const _EmptyFoldersView()
          else
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: _folders.length,
              onReorderItem: (oldIndex, newIndex) {
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

                return Card(
                  key: ValueKey(folder.name),
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),

                    leading: CircleAvatar(child: Icon(folder.icon)),

                    title: Text(
                      folder.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '${folder.description} • ${folder.chatCount} chats',
                      ),
                    ),

                    trailing: folder.isDefault
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Default',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'delete') {
                                setState(() {
                                  _folders.remove(folder);
                                });
                              }
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(
                                value: 'duplicate',
                                child: Text('Duplicate'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),

                    onTap: () {
                      context.push(NamedRoutes.editFolder);
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class FolderItem {
  final String name;
  final String description;
  final IconData icon;
  final int chatCount;
  final bool isDefault;

  const FolderItem({
    required this.name,
    required this.description,
    required this.icon,
    required this.chatCount,
    this.isDefault = false,
  });
}

class _StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Icon(icon),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),

            const SizedBox(height: 4),

            Text(subtitle),
          ],
        ),
      ),
    );
  }
}

class _EmptyFoldersView extends StatelessWidget {
  const _EmptyFoldersView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.folder_open_outlined, size: 40),
              ),

              const SizedBox(height: 20),

              const Text(
                'No Folders Yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 8),

              const Text(
                'Create folders to organize your chats and improve productivity.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              FilledButton.icon(
                onPressed: null,
                icon: const Icon(Icons.add),
                label: const Text('Create Folder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
