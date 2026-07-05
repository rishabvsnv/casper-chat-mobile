import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ChannelInfoScreen extends ConsumerWidget {
  final String channelId;

  const ChannelInfoScreen({super.key, required this.channelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Todo: Replace with actual channel data from provider using channelId
    const channelName = 'Flutter Developers';
    const username = '@flutterdevs';
    const description =
        'Official Flutter community channel. Stay updated with the latest Flutter news, releases, tutorials, and discussions.';
    const subscribers = 12456;
    const notificationsEnabled = true;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Channel Info'),
      body: ListView(
        children: [
          const SizedBox(height: 24),

          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                channelName[0],
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Text(
              channelName,
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

          const SizedBox(height: 8),

          Center(
            child: Text(
              '$subscribers subscribers',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            subtitle: Text(
              /* notificationsEnabled ? */ 'Enabled' /* : 'Disabled' */,
            ),
            trailing: Switch(value: notificationsEnabled, onChanged: (_) {}),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.link_outlined),
            title: const Text('Channel Link'),
            subtitle: const Text('https://casper.me/flutterdevs'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Subscribers'),
            subtitle: Text(subscribers.toString()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.admin_panel_settings_outlined),
            title: const Text('Administrators'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.analytics_outlined),
            title: const Text('Statistics'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Share Channel'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.search_outlined),
            title: const Text('Search Messages'),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text(
              'Leave Channel',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Leave Channel'),
                    content: const Text(
                      'Are you sure you want to leave this channel?',
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
                        child: const Text('Leave'),
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
