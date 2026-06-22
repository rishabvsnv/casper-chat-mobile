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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBlockedUserDialog();
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                const Icon(Icons.block_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${_blockedUsers.length} blocked user(s)',
                    style: Theme.of(context).textTheme.bodyMedium,
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
                hintText: 'Search blocked users',
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

          Expanded(
            child: filteredUsers.isEmpty
                ? const _EmptyBlockedUsersView()
                : ListView.separated(
                    itemCount: filteredUsers.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(user.name[0].toUpperCase()),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.username),
                            Text(
                              'Blocked ${user.blockedDate}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        isThreeLine: true,
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
                        onTap: () {
                          // Todo:
                          // Open user profile
                        },
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
            Icon(Icons.block_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No Blocked Users',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Blocked users will appear here.',
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
