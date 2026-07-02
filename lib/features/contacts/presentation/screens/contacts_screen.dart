import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/features/contacts/providers/contact_provider.dart';
import 'package:messenger/routes/routes_export.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

enum ContactSortType { name, lastSeen }

ContactSortType sortType = ContactSortType.name;

class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    final contacts = List<Map<String, dynamic>>.from(
      ref.watch(contactsProvider),
    );

    if (sortType == ContactSortType.name) {
      contacts.sort((a, b) => a["name"].compareTo(b["name"]));
    } else {
      contacts.sort((a, b) {
        final aOnline = a["online"] as bool;
        final bOnline = b["online"] as bool;

        if (aOnline && !bOnline) return -1;
        if (!aOnline && bOnline) return 1;

        return a["name"].compareTo(b["name"]);
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Contacts',
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                sortType = sortType == ContactSortType.name
                    ? ContactSortType.lastSeen
                    : ContactSortType.name;
              });
            },
            icon: Icon(
              sortType == ContactSortType.name
                  ? Icons.sort_by_alpha
                  : Icons.access_time,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: 'contact_fab',
        backgroundColor: const Color(0xff229ED9),
        elevation: 6,
        onPressed: () {},
        child: const Icon(PhosphorIconsRegular.user, color: Colors.white),
      ),

      body: ListView(
        children: [
          /// SEARCH
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: CupertinoTextField(placeholder: 'Search Contacts'),
          ),

          /// QUICK ACTIONS
          SettingsSection(
            children: [
              _actionTile(
                icon: Icons.group_outlined,
                title: 'New Group',
                onTap: () {},
              ),
              _actionTile(
                icon: Icons.lock_outline_rounded,
                title: 'New Secret Chat',
                onTap: () {},
              ),
              _actionTile(
                icon: Icons.campaign_outlined,
                title: 'New Channel',
                onTap: () {},
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
            child: Text(
              sortType == ContactSortType.name
                  ? 'Sorted by name'
                  : 'Sorted by last seen time',
              // '${contacts.length} CONTACTS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
                letterSpacing: 1,
              ),
            ),
          ),

          /* SettingsSection(
            children: contacts.map((contact) {
              return _contactTile(
                context,
                name: contact["name"],
                status: contact["status"],
                onTap: () {},
              );
            }).toList(),
          ), */
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return _contactTile(
                    context,
                    name: contact["name"],
                    status: contact["status"],
                    onTap: () {},
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  static Widget _actionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: const Color(0xff229ED9)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  static Widget _contactTile(
    BuildContext context, {
    required String name,
    required String status,
    required VoidCallback onTap,
  }) {
    final isOnline = status.toLowerCase() == 'online';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor:
            Colors.primaries[name.hashCode % Colors.primaries.length],
        child: Text(
          name[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
      subtitle: Text(
        status,
        style: TextStyle(
          color: isOnline ? const Color(0xff229ED9) : Colors.grey.shade600,
        ),
      ),
      onTap: onTap,
    );
  }
}
