import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class PermissionsScreen extends ConsumerStatefulWidget {
  const PermissionsScreen({super.key});

  @override
  ConsumerState<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends ConsumerState<PermissionsScreen> {
  bool sendMessages = true;
  bool sendMedia = true;
  bool sendStickers = true;
  bool sendPolls = true;
  bool embedLinks = true;
  bool changeInfo = false;
  bool inviteUsers = true;
  bool pinMessages = false;
  bool manageTopics = false;

  String slowMode = 'Off';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Permissions'),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Text(
              'Control what members are allowed to do in this group or channel.',
            ),
          ),

          const SizedBox(height: 8),

          _SectionHeader(title: 'MESSAGES'),

          SwitchListTile(
            value: sendMessages,
            title: const Text('Send Messages'),
            subtitle: const Text('Allow members to send text messages'),
            onChanged: (value) {
              setState(() {
                sendMessages = value;
              });
            },
          ),

          SwitchListTile(
            value: sendMedia,
            title: const Text('Send Media'),
            subtitle: const Text('Allow photos, videos, voice notes and files'),
            onChanged: (value) {
              setState(() {
                sendMedia = value;
              });
            },
          ),

          SwitchListTile(
            value: sendStickers,
            title: const Text('Send Stickers & GIFs'),
            subtitle: const Text('Allow stickers, GIFs and emojis'),
            onChanged: (value) {
              setState(() {
                sendStickers = value;
              });
            },
          ),

          SwitchListTile(
            value: sendPolls,
            title: const Text('Create Polls'),
            subtitle: const Text('Allow members to create polls'),
            onChanged: (value) {
              setState(() {
                sendPolls = value;
              });
            },
          ),

          SwitchListTile(
            value: embedLinks,
            title: const Text('Embed Links'),
            subtitle: const Text('Allow sending links with previews'),
            onChanged: (value) {
              setState(() {
                embedLinks = value;
              });
            },
          ),

          const Divider(),

          _SectionHeader(title: 'GROUP MANAGEMENT'),

          SwitchListTile(
            value: inviteUsers,
            title: const Text('Invite Users'),
            subtitle: const Text('Allow members to invite new users'),
            onChanged: (value) {
              setState(() {
                inviteUsers = value;
              });
            },
          ),

          SwitchListTile(
            value: changeInfo,
            title: const Text('Change Group Info'),
            subtitle: const Text(
              'Allow editing group name, photo and description',
            ),
            onChanged: (value) {
              setState(() {
                changeInfo = value;
              });
            },
          ),

          SwitchListTile(
            value: pinMessages,
            title: const Text('Pin Messages'),
            subtitle: const Text('Allow members to pin messages'),
            onChanged: (value) {
              setState(() {
                pinMessages = value;
              });
            },
          ),

          SwitchListTile(
            value: manageTopics,
            title: const Text('Manage Topics'),
            subtitle: const Text('Allow creating and editing topics'),
            onChanged: (value) {
              setState(() {
                manageTopics = value;
              });
            },
          ),

          const Divider(),

          _SectionHeader(title: 'ADVANCED'),

          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text('Slow Mode'),
            subtitle: Text(slowMode),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showSlowModeSelector();
            },
          ),

          ListTile(
            leading: const Icon(Icons.auto_delete_outlined),
            title: const Text('Auto Delete Messages'),
            subtitle: const Text('Disabled'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Restricted Users'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Permissions saved successfully'),
                  ),
                );
              },
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save Changes'),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _showSlowModeSelector() async {
    final options = [
      'Off',
      '10 Seconds',
      '30 Seconds',
      '1 Minute',
      '5 Minutes',
      '15 Minutes',
      '1 Hour',
    ];

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return ListTile(
                title: Text(option),
                trailing: slowMode == option ? const Icon(Icons.check) : null,
                onTap: () {
                  setState(() {
                    slowMode = option;
                  });

                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
