import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/features/settings/domain/setting_item.dart';
import 'package:messenger/features/settings/presentation/widgets/settings_search_delegate.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/shared/widgets/custom_list_tile.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<SettingItem> settingsItems = [
      SettingItem(
        title: 'Account',
        subtitle: 'Number, Username, Bio',
        icon: PhosphorIconsRegular.user,
        onTap: () => context.push(NamedRoutes.myAccount),
      ),
      SettingItem(
        title: 'Privacy & Security',
        subtitle: 'Last Seen, Devices, Passcode',
        icon: PhosphorIconsRegular.shield,
        onTap: () => context.push(NamedRoutes.privacy),
      ),
      SettingItem(
        title: 'Data and Storage',
        subtitle: 'Media and network usage',
        icon: PhosphorIconsRegular.database,
        onTap: () => context.push(NamedRoutes.storage),
      ),
      SettingItem(
        title: 'Notifications',
        subtitle: 'Messages, Groups, Calls',
        icon: PhosphorIconsRegular.bell,
        onTap: () => context.push(NamedRoutes.notifications),
      ),
      SettingItem(
        title: 'Devices',
        subtitle: 'Manage active sessions',
        icon: PhosphorIconsRegular.desktop,
        onTap: () => context.push(NamedRoutes.devices),
      ),
      SettingItem(
        title: 'Power Saving',
        subtitle: 'Reduce animations and effects',
        icon: PhosphorIconsRegular.batteryCharging,
        onTap: () {},
      ),
      SettingItem(
        title: 'Chat Settings',
        subtitle: 'Themes, Wallpaper, Appearance',
        icon: PhosphorIconsRegular.chatCircle,
        onTap: () {
          context.push(NamedRoutes.appearance);
        },
      ),
      SettingItem(
        title: 'Chat Folders',
        subtitle: 'Organize your chats',
        icon: PhosphorIconsRegular.folder,
        onTap: () => context.push(NamedRoutes.folders),
      ),
      SettingItem(
        title: 'Language',
        subtitle: 'English',
        icon: PhosphorIconsRegular.globe,
        onTap: () => context.push(NamedRoutes.language),
      ),
      SettingItem(
        title: 'Ask a Question',
        icon: PhosphorIconsRegular.question,
        onTap: () => context.push(NamedRoutes.askQues),
      ),
      SettingItem(
        title: 'FAQ',
        icon: PhosphorIconsRegular.info,
        onTap: () => context.push(NamedRoutes.casperChatFaqs),
      ),
      SettingItem(
        title: 'Features',
        icon: PhosphorIconsRegular.sparkle,
        onTap: () => context.push(NamedRoutes.casperChatFeatures),
      ),
      SettingItem(
        title: 'Privacy Policy',
        icon: PhosphorIconsRegular.lock,
        onTap: () => context.push(NamedRoutes.privacyPolicy),
      ),
    ];

    final List<List<SettingItem>> settingsSections = [
      // SECTION 1: Account & Security
      settingsItems.sublist(0, 5),

      // SECTION 2: Preferences
      settingsItems.sublist(5, 9),

      // SECTION 3: Help & Info
      settingsItems.sublist(9, settingsItems.length),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SettingsSearchDelegate(settingsItems),
              );
            },
          ),
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

            Column(
              children: settingsSections.map((section) {
                return SettingsSection(
                  children: section.map((item) {
                    final index = section.indexOf(item);

                    return Column(
                      children: [
                        CustomListTile(
                          icon: item.icon,
                          title: item.title,
                          subtitle: item.subtitle,
                          onTap: item.onTap,
                        ),
                        if (index != section.length - 1)
                          const Divider(height: 1),
                      ],
                    );
                  }).toList(),
                );
              }).toList(),
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
              icon: const Icon(PhosphorIcons.qrCode),
              onPressed: () {
                context.push(NamedRoutes.myQR);
              },
            ),

            IconButton(
              icon: const Icon(PhosphorIcons.pen),
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
