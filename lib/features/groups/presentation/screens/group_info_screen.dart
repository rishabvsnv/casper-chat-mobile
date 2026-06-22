import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class GroupInfoScreen extends ConsumerStatefulWidget {
  final String groupId;

  const GroupInfoScreen({super.key, required this.groupId});

  @override
  ConsumerState<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends ConsumerState<GroupInfoScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    // Todo: Load group using widget.groupId
    const groupName = 'Flutter Developers';
    const memberCount = 284;
    const onlineCount = 47;
    const description =
        'A community for Flutter developers to discuss development, share resources, and help each other.';
    const username = '@flutterdevelopers';

    return Scaffold(
      appBar: const CustomAppBar(title: 'Group Info'),
      body: ListView(
        children: [
          const SizedBox(height: 24),

          CircleAvatar(
            radius: 48,
            child: Text(
              groupName[0],
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Text(
              groupName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 4),

          Center(
            child: Text(
              '$memberCount members • $onlineCount online',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 4),

          Center(
            child: Text(
              username,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                    label: const Text('Voice Chat'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    label: const Text('Search'),
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
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),

          const SizedBox(height: 16),

          SwitchListTile(
            value: notificationsEnabled,
            title: const Text('Notifications'),
            subtitle: const Text('Receive group notifications'),
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Members'),
            subtitle: Text('$memberCount members'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/group-members');
            },
          ),

          ListTile(
            leading: const Icon(Icons.person_add_alt_1_outlined),
            title: const Text('Add Members'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/add-members');
            },
          ),

          ListTile(
            leading: const Icon(Icons.admin_panel_settings_outlined),
            title: const Text('Administrators'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/group-admins');
            },
          ),

          ListTile(
            leading: const Icon(Icons.block_outlined),
            title: const Text('Banned Users'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/banned-users');
            },
          ),

          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Permissions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/permissions');
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Shared Media'),
            subtitle: const Text('124 items'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.insert_drive_file_outlined),
            title: const Text('Shared Files'),
            subtitle: const Text('37 files'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.link_outlined),
            title: const Text('Shared Links'),
            subtitle: const Text('16 links'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.push_pin_outlined),
            title: const Text('Pinned Messages'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/pinned-messages');
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.report_outlined, color: Colors.orange),
            title: const Text(
              'Report Group',
              style: TextStyle(color: Colors.orange),
            ),
            onTap: () {
              context.push('/report');
            },
          ),

          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text(
              'Leave Group',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Leave Group'),
                    content: const Text(
                      'Are you sure you want to leave this group?',
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
