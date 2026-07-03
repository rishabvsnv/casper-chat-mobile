import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class InviteContactsScreen extends ConsumerStatefulWidget {
  const InviteContactsScreen({super.key});

  @override
  ConsumerState<InviteContactsScreen> createState() =>
      _InviteContactsScreenState();
}

class _InviteContactsScreenState extends ConsumerState<InviteContactsScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  final Set<String> _selectedContacts = {};

  final List<ContactModel> _contacts = [
    const ContactModel(
      id: '1',
      name: 'John Doe',
      phoneNumber: '+91 9876543210',
    ),
    const ContactModel(
      id: '2',
      name: 'Emma Wilson',
      phoneNumber: '+91 9876543211',
    ),
    const ContactModel(
      id: '3',
      name: 'Michael Smith',
      phoneNumber: '+91 9876543212',
    ),
    const ContactModel(
      id: '4',
      name: 'Sophia Brown',
      phoneNumber: '+91 9876543213',
    ),
    const ContactModel(
      id: '5',
      name: 'Alex Johnson',
      phoneNumber: '+91 9876543214',
    ),
    const ContactModel(
      id: '6',
      name: 'Robert Wilson',
      phoneNumber: '+91 9876543215',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredContacts = _contacts.where((contact) {
      if (_searchQuery.isEmpty) {
        return true;
      }

      return contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          contact.phoneNumber.contains(_searchQuery);
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Invite Friends'),
      floatingActionButton: _selectedContacts.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _inviteSelectedContacts,
              icon: const Icon(Icons.send),
              label: Text('Invite (${_selectedContacts.length})'),
            ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Row(
              children: [
                Icon(Icons.person_add_alt_1),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Invite friends to join Casper Chat and start chatting.',
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();

                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          if (_selectedContacts.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Text(
                '${_selectedContacts.length} contact(s) selected',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

          Expanded(
            child: filteredContacts.isEmpty
                ? const _EmptyContactsView()
                : ListView.separated(
                    itemCount: filteredContacts.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final contact = filteredContacts[index];

                      final isSelected = _selectedContacts.contains(contact.id);

                      return CheckboxListTile(
                        value: isSelected,
                        secondary: CircleAvatar(
                          child: Text(contact.name[0].toUpperCase()),
                        ),
                        title: Text(
                          contact.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(contact.phoneNumber),
                        onChanged: (selected) {
                          setState(() {
                            if (selected ?? false) {
                              _selectedContacts.add(contact.id);
                            } else {
                              _selectedContacts.remove(contact.id);
                            }
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _inviteSelectedContacts() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Invitation sent to ${_selectedContacts.length} contact(s)',
        ),
      ),
    );
  }
}

class _EmptyContactsView extends StatelessWidget {
  const _EmptyContactsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_search_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Contacts Found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactModel {
  final String id;
  final String name;
  final String phoneNumber;

  const ContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });
}
