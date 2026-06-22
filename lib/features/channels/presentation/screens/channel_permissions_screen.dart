import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ChannelPermissionsScreen extends ConsumerStatefulWidget {
  const ChannelPermissionsScreen({super.key});

  @override
  ConsumerState<ChannelPermissionsScreen> createState() =>
      _ChannelPermissionsScreenState();
}

class _ChannelPermissionsScreenState
    extends ConsumerState<ChannelPermissionsScreen> {
  bool sendMessages = true;
  bool sendMedia = true;
  bool sendStickers = true;
  bool embedLinks = true;
  bool createPolls = true;
  bool changeChannelInfo = false;
  bool inviteUsers = true;
  bool pinMessages = false;
  bool manageTopics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Channel Permissions'),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Text(
              'Choose what channel members are allowed to do. '
              'Administrators can always perform all actions.',
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
            subtitle: const Text('Allow photos, videos and files'),
            onChanged: (value) {
              setState(() {
                sendMedia = value;
              });
            },
          ),

          SwitchListTile(
            value: sendStickers,
            title: const Text('Send Stickers & GIFs'),
            subtitle: const Text('Allow stickers, GIFs and emoji'),
            onChanged: (value) {
              setState(() {
                sendStickers = value;
              });
            },
          ),

          SwitchListTile(
            value: embedLinks,
            title: const Text('Embed Links'),
            subtitle: const Text('Allow links with previews'),
            onChanged: (value) {
              setState(() {
                embedLinks = value;
              });
            },
          ),

          SwitchListTile(
            value: createPolls,
            title: const Text('Create Polls'),
            subtitle: const Text('Allow members to create polls'),
            onChanged: (value) {
              setState(() {
                createPolls = value;
              });
            },
          ),

          const Divider(),

          _SectionHeader(title: 'CHANNEL MANAGEMENT'),

          SwitchListTile(
            value: inviteUsers,
            title: const Text('Invite Users'),
            subtitle: const Text('Allow members to invite others'),
            onChanged: (value) {
              setState(() {
                inviteUsers = value;
              });
            },
          ),

          SwitchListTile(
            value: changeChannelInfo,
            title: const Text('Change Channel Info'),
            subtitle: const Text('Allow editing name and description'),
            onChanged: (value) {
              setState(() {
                changeChannelInfo = value;
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
            subtitle: const Text('Off'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showSlowModeDialog(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.auto_delete_outlined),
            title: const Text('Auto Delete Messages'),
            subtitle: const Text('Disabled'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Permissions saved')),
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

  Future<void> _showSlowModeDialog(BuildContext context) async {
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
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return ListTile(
                title: Text(option),
                onTap: () {
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
