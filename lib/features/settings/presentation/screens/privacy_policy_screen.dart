import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/features/settings/domain/privacy_policy_section.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = [
      const PrivacyPolicySection(
        title: 'Information We Collect',
        content:
            'Casper Chat may collect account information such as your name, email address, profile picture, phone number, and device information. We also collect usage data necessary to provide, maintain, and improve our services.',
      ),
      const PrivacyPolicySection(
        title: 'How We Use Information',
        content:
            'We use your information to operate Casper Chat, provide messaging services, improve app performance, personalize your experience, prevent abuse, and maintain security across our platform.',
      ),
      const PrivacyPolicySection(
        title: 'Data Sharing & Disclosure',
        content:
            'We do not sell your personal information. Information may be shared only when required by law, to protect our rights, or with trusted service providers that help us operate Casper Chat.',
      ),
      const PrivacyPolicySection(
        title: 'Data Security',
        content:
            'We implement industry-standard security measures including encryption, secure data storage, access controls, and monitoring systems to protect your information from unauthorized access or misuse.',
      ),
      const PrivacyPolicySection(
        title: 'Cloud Storage',
        content:
            'Messages and files may be stored securely on our cloud infrastructure to provide synchronization across your devices and ensure reliable access to your conversations.',
      ),
      const PrivacyPolicySection(
        title: 'Third-Party Services',
        content:
            'Certain features may rely on trusted third-party providers such as analytics, cloud hosting, notifications, authentication, and payment processing services. These providers have their own privacy policies.',
      ),
      const PrivacyPolicySection(
        title: 'Your Rights',
        content:
            'You may request access, correction, export, or deletion of your personal information. Depending on your location, you may also have additional privacy rights under applicable laws.',
      ),
      const PrivacyPolicySection(
        title: 'Children\'s Privacy',
        content:
            'Casper Chat is not intended for children under the age required by local regulations. We do not knowingly collect personal information from children without appropriate consent.',
      ),
      const PrivacyPolicySection(
        title: 'Policy Updates',
        content:
            'We may update this Privacy Policy from time to time. Any changes will be reflected on this page along with the updated revision date.',
      ),
      const PrivacyPolicySection(
        title: 'Contact Us',
        content:
            'If you have questions about this Privacy Policy or our privacy practices, please contact the Casper Chat support team through the Help & Support section of the application.',
      ),
    ];

    final theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Privacy Policy'),
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
                        Icons.shield_outlined,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Learn how CasperChat handles and protects your information.',
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

          /// Privacy Highlights
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.lock_outline_rounded),
                  title: Text('Encrypted'),
                  subtitle: Text('Secure communication'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.cloud_outlined),
                  title: Text('Cloud Sync'),
                  subtitle: Text('Access from all devices'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.security_outlined),
                  title: Text('Protected'),
                  subtitle: Text('Your data remains secure'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// Last Updated
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: const ListTile(
              leading: Icon(Icons.update_rounded),
              title: Text('Last Updated'),
              subtitle: Text('June 2026'),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Privacy Policy Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          ...sections.map(
            (section) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              elevation: 0,
              child: ExpansionTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.privacy_tip_outlined),
                ),
                title: Text(
                  section.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      section.content,
                      style: const TextStyle(height: 1.5),
                    ),
                  ),
                ],
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
                      Icons.favorite_outline_rounded,
                      size: 32,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Thank You For Trusting CasperChat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We are committed to keeping your conversations secure, private and protected.',
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
