import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = [
      const PrivacySection(
        title: 'Information We Collect',
        content:
            'Casper Chat may collect account information such as your name, email address, profile picture, phone number, and device information. We also collect usage data necessary to provide, maintain, and improve our services.',
      ),
      const PrivacySection(
        title: 'How We Use Information',
        content:
            'We use your information to operate Casper Chat, provide messaging services, improve app performance, personalize your experience, prevent abuse, and maintain security across our platform.',
      ),
      const PrivacySection(
        title: 'Data Sharing & Disclosure',
        content:
            'We do not sell your personal information. Information may be shared only when required by law, to protect our rights, or with trusted service providers that help us operate Casper Chat.',
      ),
      const PrivacySection(
        title: 'Data Security',
        content:
            'We implement industry-standard security measures including encryption, secure data storage, access controls, and monitoring systems to protect your information from unauthorized access or misuse.',
      ),
      const PrivacySection(
        title: 'Cloud Storage',
        content:
            'Messages and files may be stored securely on our cloud infrastructure to provide synchronization across your devices and ensure reliable access to your conversations.',
      ),
      const PrivacySection(
        title: 'Third-Party Services',
        content:
            'Certain features may rely on trusted third-party providers such as analytics, cloud hosting, notifications, authentication, and payment processing services. These providers have their own privacy policies.',
      ),
      const PrivacySection(
        title: 'Your Rights',
        content:
            'You may request access, correction, export, or deletion of your personal information. Depending on your location, you may also have additional privacy rights under applicable laws.',
      ),
      const PrivacySection(
        title: 'Children\'s Privacy',
        content:
            'Casper Chat is not intended for children under the age required by local regulations. We do not knowingly collect personal information from children without appropriate consent.',
      ),
      const PrivacySection(
        title: 'Policy Updates',
        content:
            'We may update this Privacy Policy from time to time. Any changes will be reflected on this page along with the updated revision date.',
      ),
      const PrivacySection(
        title: 'Contact Us',
        content:
            'If you have questions about this Privacy Policy or our privacy practices, please contact the Casper Chat support team through the Help & Support section of the application.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: const CustomAppBar(title: 'Privacy Policy'),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
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
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.shield_rounded,
                    size: 44,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Your Privacy Matters',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Casper Chat is committed to protecting your privacy and ensuring a secure messaging experience for everyone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, height: 1.5),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: const [
                Expanded(
                  child: _PrivacyBadge(
                    icon: Icons.lock_outline_rounded,
                    label: 'Encrypted',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _PrivacyBadge(
                    icon: Icons.shield_outlined,
                    label: 'Secure',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _PrivacyBadge(
                    icon: Icons.verified_user_outlined,
                    label: 'Protected',
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(18),
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
            child: const Row(
              children: [
                Icon(Icons.update_rounded, color: Color(0xff4F46E5)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Last Updated: June 2026',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Text(
              'Privacy Policy Details',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          ...sections.map(
            (section) => Container(
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
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xff4F46E5).withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.privacy_tip_outlined,
                    color: Color(0xff4F46E5),
                  ),
                ),
                title: Text(
                  section.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text(
                      section.content,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xff4F46E5), Color(0xff7C3AED)],
              ),
            ),
            child: const Column(
              children: [
                Icon(Icons.favorite_rounded, color: Colors.white, size: 32),
                SizedBox(height: 12),
                Text(
                  'Thank You For Trusting Casper Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'We are committed to keeping your conversations secure, private and protected.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacySection {
  final String title;
  final String content;

  const PrivacySection({required this.title, required this.content});
}

class _PrivacyBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PrivacyBadge({required this.icon, required this.label});

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
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
