import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class CasperchatFeaturesScreen extends ConsumerWidget {
  const CasperchatFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final features = [
      const FeatureItem(
        icon: Icons.sync_rounded,
        title: 'Smart Sync',
        description: 'Access conversations instantly across all your devices.',
      ),
      const FeatureItem(
        icon: Icons.lock_outline_rounded,
        title: 'Private Chats',
        description: 'Secure conversations protected with advanced encryption.',
      ),
      const FeatureItem(
        icon: Icons.groups_rounded,
        title: 'Communities',
        description: 'Build and manage large communities with powerful tools.',
      ),
      const FeatureItem(
        icon: Icons.campaign_rounded,
        title: 'Broadcasts',
        description:
            'Share updates and announcements with unlimited followers.',
      ),
      const FeatureItem(
        icon: Icons.folder_copy_outlined,
        title: 'Collections',
        description: 'Organize chats into custom categories and folders.',
      ),
      const FeatureItem(
        icon: Icons.video_call_rounded,
        title: 'HD Calls',
        description: 'Crystal-clear voice and video communication.',
      ),
      const FeatureItem(
        icon: Icons.auto_awesome_rounded,
        title: 'AI Assistants',
        description: 'Boost productivity with smart AI-powered assistants.',
      ),
      const FeatureItem(
        icon: Icons.devices_rounded,
        title: 'Universal Access',
        description: 'Stay connected on mobile, tablet and desktop.',
      ),
      const FeatureItem(
        icon: Icons.file_present_outlined,
        title: 'Large File Sharing',
        description: 'Send photos, videos and documents without hassle.',
      ),
      const FeatureItem(
        icon: Icons.palette_outlined,
        title: 'Themes',
        description: 'Customize colors, wallpapers and chat appearance.',
      ),
      const FeatureItem(
        icon: Icons.location_on_outlined,
        title: 'Nearby Connections',
        description: 'Discover people and communities around you.',
      ),
      const FeatureItem(
        icon: Icons.security_rounded,
        title: 'Advanced Security',
        description: 'Extra layers of protection for your account and data.',
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'CasperChat Features'),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const SizedBox(height: 12),

          /// Summary Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Icon(
                        Icons.auto_awesome_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CasperChat Features',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '${features.length} powerful features available',
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Highlights
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Highlights',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.lock_outline_rounded),
                  title: Text('Secure Messaging'),
                  subtitle: Text('Privacy focused conversations'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.sync_rounded),
                  title: Text('Cloud Sync'),
                  subtitle: Text('Access chats on every device'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.devices_rounded),
                  title: Text('Multi Device Support'),
                  subtitle: Text('Stay connected everywhere'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Explore Features',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          ...features.map(
            (feature) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              elevation: 0,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                leading: CircleAvatar(child: Icon(feature.icon)),

                title: Text(
                  feature.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(feature.description),
                ),

                trailing: const Icon(Icons.chevron_right_rounded),

                onTap: () {},
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Footer Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.rocket_launch_rounded,
                      size: 36,
                      color: theme.colorScheme.primary,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Built for Modern Communication',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'CasperChat combines speed, privacy, cloud synchronization and powerful communication tools into a seamless messaging experience.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureItem {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
