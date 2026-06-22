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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Folder',
        actions: [
          TextButton(onPressed: _saveFolder, child: const Text('SAVE')),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Folder Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'INCLUDED CHATS',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          SwitchListTile(
            value: includeContacts,
            title: const Text('Contacts'),
            onChanged: (value) {
              setState(() {
                includeContacts = value;
              });
            },
          ),

          SwitchListTile(
            value: includeNonContacts,
            title: const Text('Non-Contacts'),
            onChanged: (value) {
              setState(() {
                includeNonContacts = value;
              });
            },
          ),

          SwitchListTile(
            value: includeGroups,
            title: const Text('Groups'),
            onChanged: (value) {
              setState(() {
                includeGroups = value;
              });
            },
          ),

          SwitchListTile(
            value: includeChannels,
            title: const Text('Channels'),
            onChanged: (value) {
              setState(() {
                includeChannels = value;
              });
            },
          ),

          SwitchListTile(
            value: includeBots,
            title: const Text('Bots'),
            onChanged: (value) {
              setState(() {
                includeBots = value;
              });
            },
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'EXCLUDED CHATS',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          SwitchListTile(
            value: excludeMuted,
            title: const Text('Muted Chats'),
            onChanged: (value) {
              setState(() {
                excludeMuted = value;
              });
            },
          ),

          SwitchListTile(
            value: excludeRead,
            title: const Text('Read Chats'),
            onChanged: (value) {
              setState(() {
                excludeRead = value;
              });
            },
          ),

          SwitchListTile(
            value: excludeArchived,
            title: const Text('Archived Chats'),
            onChanged: (value) {
              setState(() {
                excludeArchived = value;
              });
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Included Chats'),
            subtitle: const Text('Choose specific chats'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Todo:
              // Open chat picker
            },
          ),

          ListTile(
            leading: const Icon(Icons.block_outlined),
            title: const Text('Excluded Chats'),
            subtitle: const Text('Choose chats to exclude'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Todo:
              // Open excluded chat picker
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text(
              'Delete Folder',
              style: TextStyle(color: Colors.red),
            ),
            onTap: _deleteFolder,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
