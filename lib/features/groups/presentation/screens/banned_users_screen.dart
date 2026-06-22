import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class BannedUsersScreen extends ConsumerStatefulWidget {
  const BannedUsersScreen({super.key});

  @override
  ConsumerState<BannedUsersScreen> createState() => _BannedUsersScreenState();
}

class _BannedUsersScreenState extends ConsumerState<BannedUsersScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  final List<BannedUserModel> _bannedUsers = [
    const BannedUserModel(
      id: '1',
      name: 'John Doe',
      username: '@johndoe',
      reason: 'Spam messages',
      bannedDate: '2 days ago',
    ),
    const BannedUserModel(
      id: '2',
      name: 'Emma Wilson',
      username: '@emma',
      reason: 'Abusive language',
      bannedDate: '1 week ago',
    ),
    const BannedUserModel(
      id: '3',
      name: 'Michael Smith',
      username: '@michael',
      reason: 'Scam activity',
      bannedDate: '2 weeks ago',
    ),
    const BannedUserModel(
      id: '4',
      name: 'Sophia Brown',
      username: '@sophia',
      reason: 'Repeated violations',
      bannedDate: '1 month ago',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _bannedUsers.where((user) {
      if (_searchQuery.isEmpty) {
        return true;
      }

      return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.username.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Banned Users'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo: Add banned user
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
                    '${_bannedUsers.length} banned user(s)',
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
                hintText: 'Search banned users',
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
                ? const _EmptyBannedUsersView()
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
                              user.reason,
                              style: TextStyle(color: Colors.orange.shade700),
                            ),
                            Text(
                              'Banned ${user.bannedDate}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            switch (value) {
                              case 'profile':
                                break;
                              case 'unban':
                                _unbanUser(user);
                                break;
                            }
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(
                              value: 'profile',
                              child: Text('View Profile'),
                            ),
                            PopupMenuItem(
                              value: 'unban',
                              child: Text('Unban User'),
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

  void _unbanUser(BannedUserModel user) {
    setState(() {
      _bannedUsers.removeWhere((element) => element.id == user.id);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${user.name} has been unbanned')));
  }
}

class _EmptyBannedUsersView extends StatelessWidget {
  const _EmptyBannedUsersView();

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
              'No Banned Users',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Users banned from this group or channel will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class BannedUserModel {
  final String id;
  final String name;
  final String username;
  final String reason;
  final String bannedDate;

  const BannedUserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.reason,
    required this.bannedDate,
  });
}
