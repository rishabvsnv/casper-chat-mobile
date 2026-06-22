import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/routes/named_routes.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Todo: Replace with actual user provider
    const userName = 'Rishabh';
    const username = 'rishabvsnv';
    const phoneNumber = '+91 9876543210';

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.push(NamedRoutes.profile);
                          });
                        },
                        child: const CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () {
                          context.pop();

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.push(NamedRoutes.myQR);
                          });
                        },
                        icon: const Icon(
                          Icons.qr_code_rounded,
                          color: Colors.white,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          // Todo: Theme Toggle
                        },
                        icon: const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '@$username',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    phoneNumber,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerItem(
                    context,
                    icon: Icons.group_outlined,
                    title: 'New Group',
                    onTap: () => context.push(NamedRoutes.newGroup),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.campaign_outlined,
                    title: 'New Channel',
                    onTap: () => context.push(NamedRoutes.newChannel),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'Contacts',
                    onTap: () => context.push(NamedRoutes.contacts),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.call_outlined,
                    title: 'Calls',
                    onTap: () => context.push(NamedRoutes.calls),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.location_on_outlined,
                    title: 'People Nearby',
                    onTap: () => context.push(NamedRoutes.peopleNearby),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.bookmark_outline_rounded,
                    title: 'Saved Messages',
                    onTap: () => context.push(NamedRoutes.savedMessages),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.archive_outlined,
                    title: 'Archived Chats',
                    onTap: () => context.push(NamedRoutes.archive),
                  ),

                  const Divider(),

                  _drawerItem(
                    context,
                    icon: Icons.account_circle_outlined,
                    title: 'My Profile',
                    onTap: () => context.push(NamedRoutes.profile),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    onTap: () => context.push(NamedRoutes.notifications),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.security_outlined,
                    title: 'Privacy & Security',
                    onTap: () => context.push(NamedRoutes.privacy),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.storage_outlined,
                    title: 'Storage Usage',
                    onTap: () => context.push(NamedRoutes.storage),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.devices_outlined,
                    title: 'Devices',
                    onTap: () => context.push(NamedRoutes.devices),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.folder_outlined,
                    title: 'Chat Folders',
                    onTap: () => context.push(NamedRoutes.folders),
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () => context.push(NamedRoutes.settings),
                  ),

                  const Divider(),

                  _drawerItem(
                    context,
                    icon: Icons.person_add_outlined,
                    title: 'Invite Friends',
                    onTap: () {
                      // async
                      /* await SharePlus.instance.share(
                        ShareParams(
                          text:
                              'Hey! I am using Messenger for chatting and calling.\n\n'
                              'Download it here:\n'
                              'https://yourapp.com/download',
                          subject: 'Join Messenger',
                        ),
                      ); */
                    },
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.auto_awesome_outlined,
                    title: 'Telegram Features',
                    onTap: () => context.push(NamedRoutes.telegramFeatures),
                  ),

                  const Divider(),

                  _drawerItem(
                    context,
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                              'Are you sure you want to logout?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => context.pop(),
                                child: const Text('Cancel'),
                              ),
                              FilledButton(
                                onPressed: () {
                                  context.pop();

                                  // Todo:
                                  // AuthRepository.logout();
                                  // Clear cache
                                  // Navigate to login

                                  context.go(NamedRoutes.login);
                                },
                                child: const Text('Logout'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.of(context).pop(); // close drawer first

        WidgetsBinding.instance.addPostFrameCallback((_) {
          onTap();
        });
      },
    );
  }
}
