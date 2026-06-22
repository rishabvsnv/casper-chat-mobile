import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ShareScreen extends ConsumerStatefulWidget {
  const ShareScreen({super.key});

  @override
  ConsumerState<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends ConsumerState<ShareScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  final List<ShareContact> _contacts = [
    const ShareContact(
      id: '1',
      name: 'John Doe',
      subtitle: 'online',
      isOnline: true,
    ),
    const ShareContact(
      id: '2',
      name: 'Emma Wilson',
      subtitle: 'last seen recently',
      isOnline: false,
    ),
    const ShareContact(
      id: '3',
      name: 'Michael Smith',
      subtitle: 'online',
      isOnline: true,
    ),
    const ShareContact(
      id: '4',
      name: 'Sophia Brown',
      subtitle: 'last seen today',
      isOnline: false,
    ),
    const ShareContact(
      id: '5',
      name: 'Flutter Developers',
      subtitle: '12,456 members',
      isGroup: true,
    ),
    const ShareContact(
      id: '6',
      name: 'Work Team',
      subtitle: '84 members',
      isGroup: true,
    ),
  ];

  final Set<String> _selectedContacts = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredContacts = _contacts.where((contact) {
      if (_searchQuery.isEmpty) return true;

      return contact.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Share'),
      floatingActionButton: _selectedContacts.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _shareContent,
              icon: const Icon(Icons.send),
              label: Text('Send (${_selectedContacts.length})'),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search chats',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Text(
                '${_selectedContacts.length} selected',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

          Expanded(
            child: filteredContacts.isEmpty
                ? const _EmptyShareView()
                : ListView.builder(
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contact = filteredContacts[index];

                      final isSelected = _selectedContacts.contains(contact.id);

                      return CheckboxListTile(
                        value: isSelected,
                        secondary: Stack(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                contact.isGroup ? Icons.group : Icons.person,
                              ),
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
                        subtitle: Text(contact.subtitle),
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

  void _shareContent() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shared to ${_selectedContacts.length} chat(s)')),
    );

    Navigator.pop(context);
  }
}

class _EmptyShareView extends StatelessWidget {
  const _EmptyShareView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.share_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No Chats Found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Search for a chat or contact to share with.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class ShareContact {
  final String id;
  final String name;
  final String subtitle;
  final bool isOnline;
  final bool isGroup;

  const ShareContact({
    required this.id,
    required this.name,
    required this.subtitle,
    this.isOnline = false,
    this.isGroup = false,
  });
}
