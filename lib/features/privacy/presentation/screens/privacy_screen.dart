import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  String lastSeen = 'Everybody';
  String profilePhoto = 'Everybody';
  String phoneNumber = 'My Contacts';
  String calls = 'My Contacts';
  String forwardedMessages = 'Everybody';
  String groupsAndChannels = 'Everybody';

  bool peerToPeerCalls = true;
  bool readReceipts = true;
  bool blockedUsersEnabled = true;
  bool twoStepVerification = false;
  bool passcodeLock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy and Security')),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          _SectionHeader(title: 'PRIVACY'),

          _PrivacyTile(
            title: 'Last Seen & Online',
            value: lastSeen,
            onTap: () {},
          ),

          _PrivacyTile(
            title: 'Profile Photos',
            value: profilePhoto,
            onTap: () {},
          ),

          _PrivacyTile(title: 'Phone Number', value: phoneNumber, onTap: () {}),

          _PrivacyTile(
            title: 'Forwarded Messages',
            value: forwardedMessages,
            onTap: () {},
          ),

          _PrivacyTile(title: 'Calls', value: calls, onTap: () {}),

          _PrivacyTile(
            title: 'Groups & Channels',
            value: groupsAndChannels,
            onTap: () {},
          ),

          const Divider(),

          _SectionHeader(title: 'SECURITY'),

          SwitchListTile(
            value: twoStepVerification,
            title: const Text('Two-Step Verification'),
            subtitle: const Text('Add an extra password layer'),
            onChanged: (value) {
              setState(() {
                twoStepVerification = value;
              });
            },
          ),

          SwitchListTile(
            value: passcodeLock,
            title: const Text('Passcode Lock'),
            subtitle: const Text('Lock app with PIN or biometrics'),
            onChanged: (value) {
              setState(() {
                passcodeLock = value;
              });
            },
          ),

          ListTile(
            leading: const Icon(Icons.devices_outlined),
            title: const Text('Active Sessions'),
            subtitle: const Text('Manage logged-in devices'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          _SectionHeader(title: 'MESSAGING'),

          SwitchListTile(
            value: readReceipts,
            title: const Text('Read Receipts'),
            subtitle: const Text('Let others know when messages are read'),
            onChanged: (value) {
              setState(() {
                readReceipts = value;
              });
            },
          ),

          SwitchListTile(
            value: peerToPeerCalls,
            title: const Text('Peer-to-Peer Calls'),
            subtitle: const Text('Use direct connection when possible'),
            onChanged: (value) {
              setState(() {
                peerToPeerCalls = value;
              });
            },
          ),

          const Divider(),

          _SectionHeader(title: 'SAFETY'),

          ListTile(
            leading: const Icon(Icons.block_outlined),
            title: const Text('Blocked Users'),
            subtitle: const Text('Manage blocked contacts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete Account If Away For'),
            subtitle: const Text('6 months'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Data Settings'),
            subtitle: const Text('Control data usage and storage'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _PrivacyTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _PrivacyTile({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
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
