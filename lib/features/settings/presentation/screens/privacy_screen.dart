import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/features/settings/presentation/widgets/privacy_tile_widget.dart';
import 'package:messenger/features/settings/presentation/widgets/section_header_widget.dart';
import 'package:messenger/routes/named_routes.dart';

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

          SectionHeaderWidget(title: 'PRIVACY'),

          PrivacyTileWidget(
            title: 'Last Seen & Online',
            value: lastSeen,
            onTap: () {},
          ),

          PrivacyTileWidget(
            title: 'Profile Photos',
            value: profilePhoto,
            onTap: () {},
          ),

          PrivacyTileWidget(
            title: 'Phone Number',
            value: phoneNumber,
            onTap: () {},
          ),

          PrivacyTileWidget(
            title: 'Forwarded Messages',
            value: forwardedMessages,
            onTap: () {},
          ),

          PrivacyTileWidget(title: 'Calls', value: calls, onTap: () {}),

          PrivacyTileWidget(
            title: 'Groups & Channels',
            value: groupsAndChannels,
            onTap: () {},
          ),

          const Divider(),

          SectionHeaderWidget(title: 'SECURITY'),

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
            onTap: () {
              context.push(NamedRoutes.activeSessions);
            },
          ),

          const Divider(),

          SectionHeaderWidget(title: 'MESSAGING'),

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

          SectionHeaderWidget(title: 'SAFETY'),

          ListTile(
            leading: const Icon(Icons.block_outlined),
            title: const Text('Blocked Users'),
            subtitle: const Text('Manage blocked contacts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push(NamedRoutes.blockedUsers);
            },
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
            onTap: () {
              context.push(NamedRoutes.dataUsage);
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
