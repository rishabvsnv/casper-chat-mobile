import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class AskQuestionScreen extends ConsumerStatefulWidget {
  const AskQuestionScreen({super.key});

  @override
  ConsumerState<AskQuestionScreen> createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends ConsumerState<AskQuestionScreen> {
  final _subjectController = TextEditingController();

  final _questionController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  void _submitQuestion() {
    final subject = _subjectController.text.trim();

    final question = _questionController.text.trim();

    if (subject.isEmpty || question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Question submitted successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Ask a Question'),
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
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need Help?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Send your question to the CasperChat support team.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Subject
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Subject',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  hintText: 'What is your issue?',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Question
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Question',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _questionController,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: 'Describe your problem in detail...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Topics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Popular Topics',
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
                  leading: Icon(Icons.person_outline),
                  title: Text('Account Issues'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Privacy & Security'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.chat_bubble),
                  title: Text('Chats & Messages'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.icon(
              onPressed: _submitQuestion,
              icon: const Icon(Icons.send_rounded),
              label: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
