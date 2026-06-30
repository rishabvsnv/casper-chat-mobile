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
  bool twoStepVerification = false;
  bool passcodeLock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Security')),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          // Privacy Summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.privacy_tip_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: const Text(
                  'Privacy Level',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text(
                  'Most settings are visible to your contacts',
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          SectionHeaderWidget(title: 'PRIVACY'),

          PrivacySection(
            children: [
              PrivacyTileWidget(
                title: 'Last Seen & Online',
                value: lastSeen,
                onTap: () {},
              ),
              const Divider(height: 1),
              PrivacyTileWidget(
                title: 'Profile Photos',
                value: profilePhoto,
                onTap: () {},
              ),
              const Divider(height: 1),
              PrivacyTileWidget(
                title: 'Phone Number',
                value: phoneNumber,
                onTap: () {},
              ),
              const Divider(height: 1),
              PrivacyTileWidget(
                title: 'Forwarded Messages',
                value: forwardedMessages,
                onTap: () {},
              ),
              const Divider(height: 1),
              PrivacyTileWidget(title: 'Calls', value: calls, onTap: () {}),
              const Divider(height: 1),
              PrivacyTileWidget(
                title: 'Groups & Channels',
                value: groupsAndChannels,
                onTap: () {},
              ),
            ],
          ),

          SectionHeaderWidget(title: 'SECURITY'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: const ListTile(
                leading: Icon(Icons.shield_outlined, color: Colors.green),
                title: Text('Account Protected'),
                subtitle: Text('No security issues found'),
              ),
            ),
          ),

          const SizedBox(height: 8),

          PrivacySection(
            children: [
              SwitchListTile.adaptive(
                value: twoStepVerification,
                title: const Text('Two-Step Verification'),
                subtitle: const Text('Add an extra password layer'),
                onChanged: (value) {
                  setState(() {
                    twoStepVerification = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: passcodeLock,
                title: const Text('Passcode Lock'),
                subtitle: const Text('Lock app with PIN or biometrics'),
                onChanged: (value) {
                  setState(() {
                    passcodeLock = value;
                  });
                },
              ),

              const Divider(height: 1),

              ListTile(
                leading: const CircleAvatar(
                  radius: 18,
                  child: Icon(Icons.devices_outlined, size: 18),
                ),
                title: const Text('Active Sessions'),
                subtitle: const Text('Manage logged-in devices'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  context.push(NamedRoutes.activeSessions);
                },
              ),
            ],
          ),

          SectionHeaderWidget(title: 'MESSAGING'),

          PrivacySection(
            children: [
              SwitchListTile.adaptive(
                value: readReceipts,
                title: const Text('Read Receipts'),
                subtitle: const Text('Let others know when messages are read'),
                onChanged: (value) {
                  setState(() {
                    readReceipts = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: peerToPeerCalls,
                title: const Text('Peer-to-Peer Calls'),
                subtitle: const Text('Use direct connection when possible'),
                onChanged: (value) {
                  setState(() {
                    peerToPeerCalls = value;
                  });
                },
              ),
            ],
          ),

          SectionHeaderWidget(title: 'SAFETY'),

          PrivacySection(
            children: [
              ListTile(
                leading: const Icon(Icons.block_outlined),
                title: const Text('Blocked Users'),
                subtitle: const Text('Manage blocked contacts'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  context.push(NamedRoutes.blockedUsers);
                },
              ),

              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Auto Delete Account'),
                subtitle: const Text('Inactive for 6 months'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),

              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.security_outlined),
                title: const Text('Data Settings'),
                subtitle: const Text('Control data usage and storage'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  context.push(NamedRoutes.dataUsage);
                },
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class PrivacySection extends StatelessWidget {
  final List<Widget> children;

  const PrivacySection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Column(children: children),
      ),
    );
  }
}
