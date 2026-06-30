import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class EditFolderScreen extends ConsumerStatefulWidget {
  const EditFolderScreen({super.key, this.initialName = 'Work'});

  final String initialName;

  @override
  ConsumerState<EditFolderScreen> createState() => _EditFolderScreenState();
}

class _EditFolderScreenState extends ConsumerState<EditFolderScreen> {
  late final TextEditingController _nameController;

  bool includeContacts = true;
  bool includeNonContacts = true;
  bool includeGroups = true;
  bool includeChannels = true;
  bool includeBots = false;

  bool excludeMuted = false;
  bool excludeRead = false;
  bool excludeArchived = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);

    _nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveFolder() {
    final folderName = _nameController.text.trim();

    if (folderName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Folder name cannot be empty')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$folderName saved')));

    Navigator.pop(context);
  }

  void _deleteFolder() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delete Folder'),
          content: const Text('Are you sure you want to delete this folder?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Folder deleted')));
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _switchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? subtitle,
  }) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value,
      onChanged: onChanged,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Folder',
        actions: [
          TextButton(onPressed: _saveFolder, child: const Text('SAVE')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SizedBox(height: 12),

          /// Summary Card
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
                        Icons.folder_outlined,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nameController.text.isEmpty
                                ? 'Folder'
                                : _nameController.text,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Customize which chats appear in this folder',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Folder Name
          _sectionTitle('Folder Name'),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Folder Name',
                ),
              ),
            ),
          ),

          /// Included Chats
          _sectionTitle('Included Chats'),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: Column(
              children: [
                _switchTile(
                  title: 'Contacts',
                  value: includeContacts,
                  onChanged: (value) {
                    setState(() {
                      includeContacts = value;
                    });
                  },
                ),
                const Divider(height: 1),
                _switchTile(
                  title: 'Non-Contacts',
                  value: includeNonContacts,
                  onChanged: (value) {
                    setState(() {
                      includeNonContacts = value;
                    });
                  },
                ),
                const Divider(height: 1),
                _switchTile(
                  title: 'Groups',
                  value: includeGroups,
                  onChanged: (value) {
                    setState(() {
                      includeGroups = value;
                    });
                  },
                ),
                const Divider(height: 1),
                _switchTile(
                  title: 'Channels',
                  value: includeChannels,
                  onChanged: (value) {
                    setState(() {
                      includeChannels = value;
                    });
                  },
                ),
                const Divider(height: 1),
                _switchTile(
                  title: 'Bots',
                  value: includeBots,
                  onChanged: (value) {
                    setState(() {
                      includeBots = value;
                    });
                  },
                ),
              ],
            ),
          ),

          /// Excluded Chats
          _sectionTitle('Excluded Chats'),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: Column(
              children: [
                _switchTile(
                  title: 'Muted Chats',
                  value: excludeMuted,
                  onChanged: (value) {
                    setState(() {
                      excludeMuted = value;
                    });
                  },
                ),
                const Divider(height: 1),
                _switchTile(
                  title: 'Read Chats',
                  value: excludeRead,
                  onChanged: (value) {
                    setState(() {
                      excludeRead = value;
                    });
                  },
                ),
                const Divider(height: 1),
                _switchTile(
                  title: 'Archived Chats',
                  value: excludeArchived,
                  onChanged: (value) {
                    setState(() {
                      excludeArchived = value;
                    });
                  },
                ),
              ],
            ),
          ),

          /// Specific Chats
          _sectionTitle('Specific Chats'),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.people_outline),
                  title: const Text('Included Chats'),
                  subtitle: const Text('Choose specific chats'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.block_outlined),
                  title: const Text('Excluded Chats'),
                  subtitle: const Text('Choose chats to exclude'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
              ],
            ),
          ),

          /// Danger Zone
          _sectionTitle('Danger Zone'),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: ListTile(
              leading: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
              ),
              title: const Text(
                'Delete Folder',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text('Remove this folder permanently'),
              onTap: _deleteFolder,
            ),
          ),
        ],
      ),
    );
  }
}
