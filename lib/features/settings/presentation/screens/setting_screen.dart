import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/shared/widgets/custom_list_tile.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 12),
                    Text('Log Out'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                context.go(NamedRoutes.login);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _ProfileCard(),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _PremiumCard(),
            ),

            const SizedBox(height: 12),

            SettingsSection(
              children: [
                CustomListTile(
                  icon: Icons.person_outline,
                  title: 'Account',
                  subtitle: 'Number, Username, Bio',
                  onTap: () => context.push(NamedRoutes.myAccount),
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.shield_outlined,
                  title: 'Privacy & Security',
                  subtitle: 'Last Seen, Devices, Passcode',
                  onTap: () => context.push(NamedRoutes.privacy),
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.storage_outlined,
                  title: 'Data and Storage',
                  subtitle: 'Media and network usage',
                  onTap: () => context.push(NamedRoutes.storage),
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Messages, Groups, Calls',
                  onTap: () => context.push(NamedRoutes.notifications),
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.devices_outlined,
                  title: 'Devices',
                  subtitle: 'Manage active sessions',
                  onTap: () => context.push(NamedRoutes.devices),
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.battery_saver_outlined,
                  title: 'Power Saving',
                  subtitle: 'Reduce animations and effects',
                  onTap: () {},
                ),
              ],
            ),

            SettingsSection(
              children: [
                CustomListTile(
                  icon: Icons.chat_bubble_outline,
                  title: 'Chat Settings',
                  subtitle: 'Themes, Wallpaper, Appearance',
                  onTap: () {},
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.folder_outlined,
                  title: 'Chat Folders',
                  subtitle: 'Organize your chats',
                  onTap: () => context.push(NamedRoutes.folders),
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () => context.push(NamedRoutes.language),
                ),
              ],
            ),

            /* SettingsSection(
              children: [
                CustomListTile(
                  icon: Icons.workspace_premium_outlined,
                  title: 'CasperChat Premium',
                  onTap: () {},
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.stars_outlined,
                  title: 'CasperChat Stars',
                  onTap: () {},
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.business_center_outlined,
                  title: 'CasperChat Business',
                  onTap: () {},
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.card_giftcard_outlined,
                  title: 'Send a Gift',
                  onTap: () {},
                ),
              ],
            ), */

            SettingsSection(
              children: [
                CustomListTile(
                  icon: Icons.help_outline,
                  title: 'Ask a Question',
                  onTap: () {},
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.quiz_outlined,
                  title: 'CasperChat FAQ',
                  onTap: () {},
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.auto_awesome_outlined,
                  title: 'CasperChat Features',
                  onTap: () => context.push(NamedRoutes.casperChatFeatures),
                ),
                const Divider(height: 1),
                CustomListTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () => context.push(NamedRoutes.privacyPolicy),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.tonalIcon(
                onPressed: () {
                  context.go(NamedRoutes.login);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: Text(
                'CasperChat for Android v12.8.3 (6922)',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 4),

            Center(
              child: Text(
                'store bundled arm64-v8a',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 34,
              child: const Text(
                'R',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rishabh',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text('@rishabvsnv'),
                  SizedBox(height: 2),
                  Text('+91 9876543210'),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.qr_code),
              onPressed: () {
                context.push(NamedRoutes.myQR);
              },
            ),

            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                context.push(NamedRoutes.myAccount);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: const Icon(Icons.workspace_premium),
        title: const Text('Unlock CasperChat Premium'),
        subtitle: const Text(
          'More uploads, exclusive features and faster sync',
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {},
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final List<Widget> children;

  const SettingsSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Column(children: children),
      ),
    );
  }
}
