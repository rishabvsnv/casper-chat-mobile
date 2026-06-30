import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class CasperchatFaqScreen extends ConsumerStatefulWidget {
  const CasperchatFaqScreen({super.key});

  @override
  ConsumerState<CasperchatFaqScreen> createState() =>
      _CasperchatFaqScreenState();
}

class _CasperchatFaqScreenState extends ConsumerState<CasperchatFaqScreen> {
  String _searchQuery = '';

  final List<FaqItem> _faqs = const [
    FaqItem(
      question: 'How do I create an account?',
      answer:
          'Open CasperChat, enter your phone number, verify the OTP, and complete your profile setup.',
    ),
    FaqItem(
      question: 'How can I change my profile photo?',
      answer:
          'Open Settings → Edit Profile and tap your profile picture to upload a new one.',
    ),
    FaqItem(
      question: 'How do chat folders work?',
      answer:
          'Chat folders help organize conversations into categories such as Work, Personal, Groups, and Channels.',
    ),
    FaqItem(
      question: 'Can I use CasperChat on multiple devices?',
      answer:
          'Yes. Your chats are synced across supported devices after logging into your account.',
    ),
    FaqItem(
      question: 'How do I enable dark mode?',
      answer:
          'Go to Settings → Appearance and choose Dark Mode or System Default.',
    ),
    FaqItem(
      question: 'Are my messages encrypted?',
      answer:
          'CasperChat uses modern security practices to protect your conversations and account data.',
    ),
    FaqItem(
      question: 'How do I block a user?',
      answer:
          'Open the user profile, tap the menu button, and select Block User.',
    ),
    FaqItem(
      question: 'How do notifications work?',
      answer:
          'Notification preferences can be customized globally or individually for chats and groups.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredFaqs = _faqs.where((faq) {
      final query = _searchQuery.toLowerCase();

      return faq.question.toLowerCase().contains(query) ||
          faq.answer.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'FAQ'),
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
                        Icons.help_outline_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Frequently Asked Questions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_faqs.length} help articles available',
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

          /// Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search questions',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Popular Questions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: ExpansionPanelList.radio(
              expandedHeaderPadding: EdgeInsets.zero,
              children: filteredFaqs.map((faq) {
                return ExpansionPanelRadio(
                  value: faq.question,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(
                        faq.question,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(faq.answer),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.icon(
              onPressed: () {
                // Navigate to AskQuestionScreen
              },
              icon: const Icon(Icons.support_agent_rounded),
              label: const Text('Ask a Question'),
            ),
          ),
        ],
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}
