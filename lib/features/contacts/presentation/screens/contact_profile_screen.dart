import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ContactProfileScreen extends ConsumerStatefulWidget {
  final String userId;

  const ContactProfileScreen({super.key, required this.userId});

  @override
  ConsumerState<ContactProfileScreen> createState() =>
      _ContactProfileScreenState();
}

class _ContactProfileScreenState extends ConsumerState<ContactProfileScreen> {
  bool notificationsEnabled = true;
  bool isBlocked = false;

  @override
  Widget build(BuildContext context) {
    // Todo: Load user by widget.userId
    const name = 'John Doe';
    const username = '@johndoe';
    const phone = '+91 9876543210';
    const bio = 'Flutter Developer • Building scalable mobile applications.';
    const mutualGroups = 5;
    const sharedMedia = 124;
    const sharedFiles = 32;
    const sharedLinks = 18;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
      body: ListView(
        children: [
          const SizedBox(height: 24),

          Center(
            child: CircleAvatar(
              radius: 52,
              child: Text(
                name[0],
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 4),

          Center(
            child: Text(
              username,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 4),

          Center(
            child: Text(phone, style: Theme.of(context).textTheme.bodyMedium),
          ),

          const SizedBox(height: 8),

          Center(
            child: Text(
              'online',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      // Todo:
                      // Open chat
                    },
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('Message'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Todo:
                      // Start call
                    },
                    icon: const Icon(Icons.call_outlined),
                    label: const Text('Call'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(bio, style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),

          const SizedBox(height: 16),

          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            subtitle: Text(notificationsEnabled ? 'Enabled' : 'Disabled'),
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Shared Media'),
            subtitle: Text('$sharedMedia items'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.insert_drive_file_outlined),
            title: const Text('Shared Files'),
            subtitle: Text('$sharedFiles files'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.link_outlined),
            title: const Text('Shared Links'),
            subtitle: Text('$sharedLinks links'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.groups_outlined),
            title: const Text('Groups in Common'),
            subtitle: Text('$mutualGroups groups'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.search_outlined),
            title: const Text('Search Messages'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: Icon(
              isBlocked ? Icons.lock_open_outlined : Icons.block_outlined,
              color: Colors.orange,
            ),
            title: Text(
              isBlocked ? 'Unblock User' : 'Block User',
              style: const TextStyle(color: Colors.orange),
            ),
            onTap: () {
              setState(() {
                isBlocked = !isBlocked;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBlocked ? 'User blocked' : 'User unblocked'),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text(
              'Delete Contact',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Delete Contact'),
                    content: const Text(
                      'Are you sure you want to remove this contact?',
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
                          Navigator.pop(context);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
