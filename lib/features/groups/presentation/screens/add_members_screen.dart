import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class AddMembersScreen extends ConsumerStatefulWidget {
  const AddMembersScreen({super.key});

  @override
  ConsumerState<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends ConsumerState<AddMembersScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  final Set<String> _selectedMembers = {};

  final List<MemberModel> _contacts = [
    const MemberModel(
      id: '1',
      name: 'John Doe',
      username: '@johndoe',
      isOnline: true,
    ),
    const MemberModel(
      id: '2',
      name: 'Emma Wilson',
      username: '@emma',
      isOnline: true,
    ),
    const MemberModel(id: '3', name: 'Michael Smith', username: '@michael'),
    const MemberModel(id: '4', name: 'Sophia Brown', username: '@sophia'),
    const MemberModel(
      id: '5',
      name: 'Alex Johnson',
      username: '@alex',
      isOnline: true,
    ),
    const MemberModel(id: '6', name: 'Robert Wilson', username: '@robert'),
    const MemberModel(id: '7', name: 'Flutter Dev', username: '@flutterdev'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addMembers() {
    if (_selectedMembers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one member')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_selectedMembers.length} member(s) added')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final filteredContacts = _contacts.where((contact) {
      if (_searchQuery.isEmpty) {
        return true;
      }

      return contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          contact.username.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Members'),
      floatingActionButton: _selectedMembers.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _addMembers,
              icon: const Icon(Icons.person_add_alt_1),
              label: Text('Add (${_selectedMembers.length})'),
            )
          : null,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Row(
              children: [
                Icon(Icons.group_add_outlined),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Select contacts to add to the group or channel.',
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
                        onPressed: () {
                          _searchController.clear();

                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        icon: const Icon(Icons.clear),
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

          if (_selectedMembers.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Text(
                '${_selectedMembers.length} selected',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

          Expanded(
            child: filteredContacts.isEmpty
                ? const _EmptyMembersView()
                : ListView.separated(
                    itemCount: filteredContacts.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final contact = filteredContacts[index];

                      final selected = _selectedMembers.contains(contact.id);

                      return CheckboxListTile(
                        value: selected,
                        secondary: Stack(
                          children: [
                            CircleAvatar(
                              child: Text(contact.name[0].toUpperCase()),
                            ),
                            if (contact.isOnline)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Text(
                          contact.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(contact.username),
                        onChanged: (value) {
                          setState(() {
                            if (value ?? false) {
                              _selectedMembers.add(contact.id);
                            } else {
                              _selectedMembers.remove(contact.id);
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
}

class _EmptyMembersView extends StatelessWidget {
  const _EmptyMembersView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.group_outlined, size: 80, color: Colors.grey.shade400),
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

class MemberModel {
  final String id;
  final String name;
  final String username;
  final bool isOnline;

  const MemberModel({
    required this.id,
    required this.name,
    required this.username,
    this.isOnline = false,
  });
}
