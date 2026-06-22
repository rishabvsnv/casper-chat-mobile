import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class GroupAdminsScreen extends ConsumerWidget {
  const GroupAdminsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admins = [
      const AdminModel(name: 'John Doe', role: 'Owner', isOnline: true),
      const AdminModel(
        name: 'Emma Wilson',
        role: 'Administrator',
        isOnline: true,
      ),
      const AdminModel(
        name: 'Michael Smith',
        role: 'Administrator',
        isOnline: false,
      ),
      const AdminModel(
        name: 'Sophia Brown',
        role: 'Moderator',
        isOnline: false,
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Group Administrators'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo: Add administrator
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Row(
              children: [
                Icon(Icons.admin_panel_settings_outlined),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Group administrators can manage members, messages, permissions, topics, and group settings.',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: admins.isEmpty
                ? const _EmptyAdminsView()
                : ListView.separated(
                    itemCount: admins.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final admin = admins[index];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(admin.name[0].toUpperCase()),
                        ),
                        title: Text(
                          admin.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(admin.role),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (admin.isOnline)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            const SizedBox(width: 12),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () {
                          _showAdminActions(context, admin);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAdminActions(BuildContext context, AdminModel admin) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('View Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.security_outlined),
                title: const Text('Edit Permissions'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.group_outlined),
                title: const Text('Manage Members'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.gavel_outlined),
                title: const Text('Restrict Member'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.block_outlined),
                title: const Text('Ban Member'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.forum_outlined),
                title: const Text('Manage Topics'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.push_pin_outlined),
                title: const Text('Manage Pinned Messages'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                ),
                title: const Text(
                  'Remove Admin',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyAdminsView extends StatelessWidget {
  const _EmptyAdminsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.admin_panel_settings_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Administrators',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Group administrators will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class AdminModel {
  final String name;
  final String role;
  final bool isOnline;

  const AdminModel({
    required this.name,
    required this.role,
    required this.isOnline,
  });
}
