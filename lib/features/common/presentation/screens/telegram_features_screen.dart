import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class TelegramFeaturesScreen extends ConsumerWidget {
  const TelegramFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final features = [
      const FeatureItem(
        icon: Icons.cloud_outlined,
        title: 'Cloud Chats',
        description:
            'Access your messages from all devices with unlimited cloud storage.',
      ),
      const FeatureItem(
        icon: Icons.lock_outline,
        title: 'Secret Chats',
        description:
            'End-to-end encrypted conversations with self-destruct timers.',
      ),
      const FeatureItem(
        icon: Icons.groups_outlined,
        title: 'Large Groups',
        description:
            'Create communities with thousands of members and powerful moderation tools.',
      ),
      const FeatureItem(
        icon: Icons.campaign_outlined,
        title: 'Channels',
        description: 'Broadcast messages to unlimited subscribers.',
      ),
      const FeatureItem(
        icon: Icons.folder_outlined,
        title: 'Chat Folders',
        description: 'Organize conversations into custom folders and tabs.',
      ),
      const FeatureItem(
        icon: Icons.call_outlined,
        title: 'Voice & Video Calls',
        description: 'Secure, high-quality voice and video calls.',
      ),
      const FeatureItem(
        icon: Icons.auto_awesome_outlined,
        title: 'Animated Stickers',
        description:
            'Express yourself with rich animated stickers and reactions.',
      ),
      const FeatureItem(
        icon: Icons.smart_toy_outlined,
        title: 'Bots',
        description: 'Automate tasks and interact with powerful Telegram bots.',
      ),
      const FeatureItem(
        icon: Icons.devices_outlined,
        title: 'Multi-Device Sync',
        description:
            'Use Telegram simultaneously on phones, tablets, and desktops.',
      ),
      const FeatureItem(
        icon: Icons.storage_outlined,
        title: 'File Sharing',
        description:
            'Send large files, documents, photos, and videos with ease.',
      ),
      const FeatureItem(
        icon: Icons.palette_outlined,
        title: 'Themes & Customization',
        description:
            'Personalize the app with themes, wallpapers, and chat colors.',
      ),
      const FeatureItem(
        icon: Icons.location_on_outlined,
        title: 'People Nearby',
        description: 'Discover people and groups around your location.',
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Telegram Features'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              children: [
                Icon(
                  Icons.send_rounded,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Why Telegram?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fast, secure, powerful messaging with cloud synchronization and advanced communication tools.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: features.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final feature = features[index];

                return ListTile(
                  leading: CircleAvatar(child: Icon(feature.icon)),
                  title: Text(
                    feature.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(feature.description),
                );
              },
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
