import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class CasperchatFeaturesScreen extends ConsumerWidget {
  const CasperchatFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      backgroundColor: const Color(0xffF8FAFC),
      appBar: const CustomAppBar(title: 'CasperChat Features'),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xff4F46E5),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            icon: const Icon(Icons.rocket_launch_rounded),
            label: const Text(
              'Start Messaging',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // Hero Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff4F46E5), Color(0xff7C3AED)],
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chat_bubble_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Welcome to Casper Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '${features.length}+ Powerful Features',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),

                const SizedBox(height: 12),

                const Text(
                  'A secure, fast and intelligent messaging platform designed for modern communication.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, height: 1.5),
                ),
              ],
            ),
          ),

          // Statistics
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: const [
                Expanded(
                  child: _StatCard(
                    icon: Icons.shield_outlined,
                    title: '100%',
                    subtitle: 'Secure',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.cloud_done_outlined,
                    title: 'Cloud',
                    subtitle: 'Synced',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.flash_on_outlined,
                    title: 'Fast',
                    subtitle: 'Delivery',
                  ),
                ),
              ],
            ),
          ),

          // Banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xff4F46E5), Color(0xff7C3AED)],
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 34),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Casper Chat combines privacy, speed and intelligent communication tools in one place.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Text(
              'Explore Features',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          ...features.map(
            (feature) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),

                  leading: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xff4F46E5).withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(feature.icon, color: const Color(0xff4F46E5)),
                  ),

                  title: Text(
                    feature.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      feature.description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xff4F46E5)),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
