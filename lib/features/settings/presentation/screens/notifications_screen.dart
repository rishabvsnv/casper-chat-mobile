import 'package:flutter/material.dart';
import 'package:messenger/features/settings/presentation/widgets/section_header_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool privateChats = true;
  bool groups = true;
  bool channels = true;

  bool messagePreview = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  bool inAppSounds = true;
  bool inAppVibration = true;
  bool inAppPreview = true;

  bool contactJoinedTelegram = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          // SUMMARY CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: Icon(
                        Icons.notifications_active,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifications Enabled',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Receive alerts for chats, groups and calls.',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          SectionHeaderWidget(title: 'MESSAGE NOTIFICATIONS'),

          _SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: privateChats,
                title: const Text('Private Chats'),
                subtitle: const Text('Notifications for private conversations'),
                onChanged: (value) {
                  setState(() {
                    privateChats = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: groups,
                title: const Text('Groups'),
                subtitle: const Text('Notifications for group chats'),
                onChanged: (value) {
                  setState(() {
                    groups = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: channels,
                title: const Text('Channels'),
                subtitle: const Text('Notifications for channels'),
                onChanged: (value) {
                  setState(() {
                    channels = value;
                  });
                },
              ),
            ],
          ),

          SectionHeaderWidget(title: 'GENERAL'),

          _SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: messagePreview,
                title: const Text('Message Preview'),
                subtitle: const Text('Show message text in notifications'),
                onChanged: (value) {
                  setState(() {
                    messagePreview = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: soundEnabled,
                title: const Text('Sound'),
                subtitle: const Text('Play notification sounds'),
                onChanged: (value) {
                  setState(() {
                    soundEnabled = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: vibrationEnabled,
                title: const Text('Vibration'),
                subtitle: const Text('Vibrate for notifications'),
                onChanged: (value) {
                  setState(() {
                    vibrationEnabled = value;
                  });
                },
              ),
            ],
          ),

          SectionHeaderWidget(title: 'IN-APP NOTIFICATIONS'),

          _SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: inAppSounds,
                title: const Text('In-App Sounds'),
                onChanged: (value) {
                  setState(() {
                    inAppSounds = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: inAppVibration,
                title: const Text('In-App Vibration'),
                onChanged: (value) {
                  setState(() {
                    inAppVibration = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: inAppPreview,
                title: const Text('In-App Preview'),
                onChanged: (value) {
                  setState(() {
                    inAppPreview = value;
                  });
                },
              ),
            ],
          ),

          SectionHeaderWidget(title: 'EVENTS'),

          _SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: contactJoinedTelegram,
                title: const Text('Contact Joined CasperChat'),
                subtitle: const Text('Notify when contacts join'),
                onChanged: (value) {
                  setState(() {
                    contactJoinedTelegram = value;
                  });
                },
              ),
            ],
          ),

          SectionHeaderWidget(title: 'ADVANCED SETTINGS'),

          _SettingsCard(
            children: [
              ListTile(
                leading: const Icon(Icons.do_not_disturb_alt_outlined),
                title: const Text('Do Not Disturb'),
                subtitle: const Text('Manage mute schedules'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),

              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.music_note_outlined),
                title: const Text('Notification Sound'),
                subtitle: const Text('Default'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),
            ],
          ),

          SectionHeaderWidget(title: 'RESET'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(Icons.restart_alt, color: Colors.red),
                title: const Text('Reset Notifications'),
                subtitle: const Text('Restore default notification settings'),
                onTap: _showResetDialog,
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _showResetDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Reset Notifications'),
          content: const Text('Restore all notification settings to default?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification settings reset')),
      );
    }
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

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
