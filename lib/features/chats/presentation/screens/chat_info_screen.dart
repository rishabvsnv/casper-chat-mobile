import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ChatInfoScreen extends ConsumerStatefulWidget {
  const ChatInfoScreen({super.key});

  @override
  ConsumerState<ChatInfoScreen> createState() => _ChatInfoScreenState();
}

class _ChatInfoScreenState extends ConsumerState<ChatInfoScreen> {
  bool notificationsEnabled = true;
  bool pinnedChat = false;

  @override
  Widget build(BuildContext context) {
    // Todo: Replace with actual chat/user data
    const userName = 'John Doe';
    const username = '@johndoe';
    const phoneNumber = '+91 9876543210';
    const bio =
        'Flutter Developer • Building amazing apps with Flutter and Riverpod.';
    const sharedMediaCount = 124;
    const sharedFilesCount = 32;
    const sharedLinksCount = 18;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Chat Info'),
      body: ListView(
        children: [
          const SizedBox(height: 24),

          Center(
            child: CircleAvatar(
              radius: 55,
              child: Text(
                userName[0],
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
              userName,
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
            child: Text(
              phoneNumber,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(bio, style: Theme.of(context).textTheme.bodyMedium),
              ),
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

          ListTile(
            leading: const Icon(Icons.push_pin_outlined),
            title: const Text('Pin Chat'),
            subtitle: Text(pinnedChat ? 'Pinned' : 'Not pinned'),
            trailing: Switch(
              value: pinnedChat,
              onChanged: (value) {
                setState(() {
                  pinnedChat = value;
                });
              },
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Shared Media'),
            subtitle: Text('$sharedMediaCount items'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.insert_drive_file_outlined),
            title: const Text('Shared Files'),
            subtitle: Text('$sharedFilesCount files'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.link_outlined),
            title: const Text('Shared Links'),
            subtitle: Text('$sharedLinksCount links'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.search_outlined),
            title: const Text('Search Messages'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.wallpaper_outlined),
            title: const Text('Chat Wallpaper'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.block_outlined, color: Colors.orange),
            title: const Text(
              'Block User',
              style: TextStyle(color: Colors.orange),
            ),
            onTap: () {
              _showBlockDialog(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text(
              'Delete Chat',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              _showDeleteDialog(context);
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showBlockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Block User'),
          content: const Text('Are you sure you want to block this user?'),
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
              child: const Text('Block'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delete Chat'),
          content: const Text('Are you sure you want to delete this chat?'),
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
  }
}
