import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/features/contacts/providers/device_contacts_provider.dart';
import 'package:messenger/routes/named_routes.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactsAsync = ref.watch(deviceContactsProvider);

    final registeredNumbers = {
      '+918319168878',
      '+919770134581',
      '+918085285836',
    };

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
      body: contactsAsync.when(
        data: (contacts) {
          final sortedContacts = [...contacts];

          sortedContacts.sort((a, b) {
            final aName = (a.displayName ?? '').toLowerCase();
            final bName = (b.displayName ?? '').toLowerCase();
            return aName.compareTo(bName);
          });

          final filteredContacts = sortedContacts.where((contact) {
            final name = (contact.displayName ?? '').toLowerCase();

            return name.contains(_searchQuery.toLowerCase());
          }).toList();

          return ListView(
            children: [
              /// SEARCH
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: CupertinoTextField(
                  controller: _searchController,
                  placeholder: 'Search Contacts',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(
                      CupertinoIcons.search,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),

              /// QUICK ACTIONS
              Card(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                elevation: 0,
                child: Column(
                  children: [
                    _actionTile(
                      icon: Icons.group_outlined,
                      title: 'New Group',
                      onTap: () {
                        context.push(NamedRoutes.newGroup);
                      },
                    ),
                    _actionTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'New Secret Chat',
                      onTap: () {
                        // context.push(NamedRoutes.newGroup);
                      },
                    ),
                    _actionTile(
                      icon: Icons.campaign_outlined,
                      title: 'New Channel',
                      onTap: () {
                        context.push(NamedRoutes.newChannel);
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
                child: Text(
                  '${filteredContacts.length} CONTACTS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                    letterSpacing: 1,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contact = filteredContacts[index];

                      final name = contact.displayName ?? 'Unknown';

                      /* final phone = contact.phones.isNotEmpty
                          ? contact.phones.first.number
                          : 'No number'; */

                      final isCasperUser = contact.phones.any(
                        (p) => registeredNumbers.contains(
                          p.number.replaceAll(' ', ''),
                        ),
                      );

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor:
                              Colors.primaries[name.hashCode %
                                  Colors.primaries.length],
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          isCasperUser
                              ? 'On Casper Chat'
                              : 'Invite to Casper Chat',
                          style: TextStyle(
                            color: isCasperUser ? Colors.green : Colors.grey,
                          ),
                        ),
                        /* subtitle: Text(
                          phone,
                          style: TextStyle(color: Colors.grey.shade600),
                        ), */
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 100),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
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
}
