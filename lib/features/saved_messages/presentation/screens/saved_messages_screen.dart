import 'package:flutter/material.dart';

class SavedMessagesScreen extends StatelessWidget {
  const SavedMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = [
      const SavedMessage(
        text: 'Flutter Riverpod architecture notes',
        time: '10:24 AM',
      ),
      const SavedMessage(
        text: 'Remember to implement chat pagination.',
        time: 'Yesterday',
      ),
      const SavedMessage(text: 'https://flutter.dev', time: 'Yesterday'),
      const SavedMessage(
        text: 'Telegram clone feature checklist.',
        time: 'Monday',
      ),
      const SavedMessage(text: 'UI inspiration screenshots.', time: 'Jun 15'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Messages')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Row(
              children: [
                Icon(Icons.bookmark_outline),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Saved Messages is your private cloud storage for notes, links, files, and forwarded messages.',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: messages.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final message = messages[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.text,
                                style: const TextStyle(fontSize: 15),
                              ),
                              const SizedBox(height: 6),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  message.time,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SavedMessage {
  final String text;
  final String time;

  const SavedMessage({required this.text, required this.time});
}
