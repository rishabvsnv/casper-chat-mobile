import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/features/contacts/providers/device_contacts_provider.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class NewGroupScreen extends ConsumerStatefulWidget {
  const NewGroupScreen({super.key});

  @override
  ConsumerState<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends ConsumerState<NewGroupScreen> {
  final Set<String> _selectedUsers = {};

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedUsers.contains(id)) {
        _selectedUsers.remove(id);
      } else {
        _selectedUsers.add(id);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactsAsync = ref.watch(deviceContactsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('New Group'),
            Text(
              '${_selectedUsers.length} members selected',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),

      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _selectedUsers.isNotEmpty ? 1 : 0.4,
        child: FloatingActionButton.extended(
          onPressed: _selectedUsers.isNotEmpty ? () {} : null,
          icon: const Icon(Icons.arrow_forward),
          label: Text('${_selectedUsers.length}'),
        ),
      ),

      body: contactsAsync.when(
        data: (contacts) {
          final filteredContacts = contacts.where((contact) {
            final name = (contact.displayName ?? '').toLowerCase();

            return name.contains(_searchQuery.toLowerCase());
          }).toList();

          filteredContacts.sort((a, b) {
            final aName = (a.displayName ?? '').toLowerCase();

            final bName = (b.displayName ?? '').toLowerCase();

            return aName.compareTo(bName);
          });

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: CupertinoTextField(
                  controller: _searchController,
                  placeholder: 'Search contacts',
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

              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _selectedUsers.isNotEmpty ? 90 : 0,
                child: _selectedUsers.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        itemCount: _selectedUsers.length,
                        itemBuilder: (context, index) {
                          final id = _selectedUsers.elementAt(index);

                          final contact = contacts.firstWhere(
                            (e) => e.id == id,
                          );

                          final name = contact.displayName ?? 'Unknown';

                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Chip(
                              avatar: CircleAvatar(child: Text(name[0])),
                              label: Text(name),
                              onDeleted: () => _toggleSelection(id),
                            ),
                          );
                        },
                      ),
              ),

              Expanded(
                child: ListView.separated(
                  itemCount: filteredContacts.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final contact = filteredContacts[index];

                    final name = contact.displayName ?? 'Unknown';
                    final phone = contact.phones.isNotEmpty
                        ? contact.phones.first.number
                        : 'No number';

                    final isSelected = _selectedUsers.contains(contact.id);

                    return InkWell(
                      onTap: () => _toggleSelection(contact.id!),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: isSelected
                            ? Colors.blue.withValues(alpha: 0.08)
                            : Colors.transparent,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor:
                                Colors.primaries[name.hashCode %
                                    Colors.primaries.length],
                            child: Text(
                              name[0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(name),
                          subtitle: Text(phone),
                          trailing: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Color(0xff229ED9),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }
}
