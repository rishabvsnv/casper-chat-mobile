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
          const SizedBox(height: 8),

          SectionHeaderWidget(title: 'MESSAGE NOTIFICATIONS'),

          SwitchListTile(
            value: privateChats,
            title: const Text('Private Chats'),
            subtitle: const Text('Notifications for private conversations'),
            onChanged: (value) {
              setState(() {
                privateChats = value;
              });
            },
          ),

          SwitchListTile(
            value: groups,
            title: const Text('Groups'),
            subtitle: const Text('Notifications for group chats'),
            onChanged: (value) {
              setState(() {
                groups = value;
              });
            },
          ),

          SwitchListTile(
            value: channels,
            title: const Text('Channels'),
            subtitle: const Text('Notifications for channels'),
            onChanged: (value) {
              setState(() {
                channels = value;
              });
            },
          ),

          const Divider(),

          SectionHeaderWidget(title: 'GENERAL'),

          SwitchListTile(
            value: messagePreview,
            title: const Text('Message Preview'),
            subtitle: const Text('Show message text in notifications'),
            onChanged: (value) {
              setState(() {
                messagePreview = value;
              });
            },
          ),

          SwitchListTile(
            value: soundEnabled,
            title: const Text('Sound'),
            subtitle: const Text('Play notification sounds'),
            onChanged: (value) {
              setState(() {
                soundEnabled = value;
              });
            },
          ),

          SwitchListTile(
            value: vibrationEnabled,
            title: const Text('Vibration'),
            subtitle: const Text('Vibrate for notifications'),
            onChanged: (value) {
              setState(() {
                vibrationEnabled = value;
              });
            },
          ),

          const Divider(),

          SectionHeaderWidget(title: 'IN-APP NOTIFICATIONS'),

          SwitchListTile(
            value: inAppSounds,
            title: const Text('In-App Sounds'),
            onChanged: (value) {
              setState(() {
                inAppSounds = value;
              });
            },
          ),

          SwitchListTile(
            value: inAppVibration,
            title: const Text('In-App Vibration'),
            onChanged: (value) {
              setState(() {
                inAppVibration = value;
              });
            },
          ),

          SwitchListTile(
            value: inAppPreview,
            title: const Text('In-App Preview'),
            onChanged: (value) {
              setState(() {
                inAppPreview = value;
              });
            },
          ),

          const Divider(),

          SectionHeaderWidget(title: 'EVENTS'),

          SwitchListTile(
            value: contactJoinedTelegram,
            title: const Text('Contact Joined Telegram'),
            subtitle: const Text('Notify when contacts join'),
            onChanged: (value) {
              setState(() {
                contactJoinedTelegram = value;
              });
            },
          ),

          ListTile(
            leading: const Icon(Icons.do_not_disturb),
            title: const Text('Do Not Disturb'),
            subtitle: const Text('Manage mute schedules'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.restart_alt),
            title: const Text('Reset Notifications'),
            subtitle: const Text('Restore default notification settings'),
            onTap: () {},
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
