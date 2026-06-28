import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/features/contacts/domain/call_model.dart';
import 'package:messenger/routes/routes_export.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calls = [
      CallModel(
        name: 'John Doe',
        time: 'last seen Today at 10:24 AM,',
        isIncoming: true,
      ),
      CallModel(
        name: 'Emma Wilson',
        time: 'last seen Today at 09:12 AM,',
        isIncoming: false,
      ),
      CallModel(
        name: 'Alex Johnson',
        time: 'last seen Yesterday at 08:45 PM,',
        isIncoming: true,
      ),
      CallModel(
        name: 'Sophia Brown',
        time: 'last seen Yesterday at 05:10 PM,',
        isIncoming: false,
      ),
      CallModel(
        name: 'Michael Smith',
        time: 'last seen Monday at 11:30 AM,',
        isIncoming: true,
      ),
      CallModel(
        name: 'John Doe',
        time: 'last seen Today at 10:24 AM,',
        isIncoming: true,
      ),
      CallModel(
        name: 'Emma Wilson',
        time: 'last seen Today at 09:12 AM,',
        isIncoming: false,
      ),
      CallModel(
        name: 'Alex Johnson',
        time: 'last seen Yesterday at 08:45 PM,',
        isIncoming: true,
      ),
      CallModel(
        name: 'Sophia Brown',
        time: 'last seen Yesterday at 05:10 PM,',
        isIncoming: false,
      ),
      CallModel(
        name: 'Michael Smith',
        time: 'last seen Monday at 11:30 AM,',
        isIncoming: true,
      ),
      CallModel(
        name: 'John Doe',
        time: 'last seen Today at 10:24 AM,',
        isIncoming: true,
      ),
      CallModel(
        name: 'Emma Wilson',
        time: 'last seen Today at 09:12 AM,',
        isIncoming: false,
      ),
      CallModel(
        name: 'Alex Johnson',
        time: 'last seen Yesterday at 08:45 PM,',
        isIncoming: true,
      ),
      CallModel(
        name: 'Sophia Brown',
        time: 'last seen Yesterday at 05:10 PM,',
        isIncoming: false,
      ),
      CallModel(
        name: 'Michael Smith',
        time: 'last seen Monday at 11:30 AM,',
        isIncoming: true,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Contacts',
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.sort))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SettingsSection(
              children: [
                _profileTile(
                  icon: Icons.person,
                  title: 'Invite Friends',
                  onTap: () {},
                ),

                _profileTile(
                  icon: Icons.shield_outlined,
                  title: 'Recent calls',
                  onTap: () {},
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 6),
              child: Text(
                'SETTINGS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                  letterSpacing: 1,
                ),
              ),
            ),
            SettingsSection(
              children: [
                ...calls.map(
                  (user) => _profileTile(
                    icon: Icons.person,
                    title: user.name,
                    subtitle: user.time,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _profileTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }
}
