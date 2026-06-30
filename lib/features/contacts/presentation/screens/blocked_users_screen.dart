import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class BlockedUsersScreen extends ConsumerStatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  ConsumerState<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends ConsumerState<BlockedUsersScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  final List<BlockedUser> _blockedUsers = [
    const BlockedUser(
      id: '1',
      name: 'John Doe',
      username: '@johndoe',
      blockedDate: '2 days ago',
    ),
    const BlockedUser(
      id: '2',
      name: 'Emma Wilson',
      username: '@emma',
      blockedDate: '1 week ago',
    ),
    const BlockedUser(
      id: '3',
      name: 'Michael Smith',
      username: '@michael',
      blockedDate: '3 weeks ago',
    ),
    const BlockedUser(
      id: '4',
      name: 'Sophia Brown',
      username: '@sophia',
      blockedDate: '1 month ago',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _blockedUsers.where((user) {
      if (_searchQuery.isEmpty) return true;

      return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.username.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Blocked Users'),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddBlockedUserDialog,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Block User'),
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.errorContainer,
                      child: Icon(
                        Icons.block,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Blocked Users',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_blockedUsers.length} blocked account(s)',
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search blocked users',
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
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: filteredUsers.isEmpty
                ? const _EmptyBlockedUsersView()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          elevation: 0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),

                            leading: CircleAvatar(
                              radius: 24,
                              child: Text(
                                user.name[0].toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            title: Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.username),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Blocked ${user.blockedDate}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),

                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'unblock') {
                                  _unblockUser(user);
                                }
                              },
                              itemBuilder: (_) => const [
                                PopupMenuItem(
                                  value: 'profile',
                                  child: Text('View Profile'),
                                ),
                                PopupMenuItem(
                                  value: 'unblock',
                                  child: Text('Unblock User'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _unblockUser(BlockedUser user) {
    setState(() {
      _blockedUsers.removeWhere((element) => element.id == user.id);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${user.name} unblocked')));
  }

  void _showAddBlockedUserDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Open contacts to block a user')),
    );
  }
}

class _EmptyBlockedUsersView extends StatelessWidget {
  const _EmptyBlockedUsersView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 42,
              child: Icon(
                Icons.block_outlined,
                size: 42,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'No Blocked Users',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(
              'People you block will appear here. They won\'t be able to send messages or call you.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class BlockedUser {
  final String id;
  final String name;
  final String username;
  final String blockedDate;

  const BlockedUser({
    required this.id,
    required this.name,
    required this.username,
    required this.blockedDate,
  });
}
