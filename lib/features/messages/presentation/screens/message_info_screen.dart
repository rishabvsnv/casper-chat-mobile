import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/features/saved_messages/domain/saved_message.dart';

class MessageInfoScreen extends ConsumerStatefulWidget {
  final String chatId;
  final String userName;

  const MessageInfoScreen({
    super.key,
    required this.chatId,
    required this.userName,
  });

  @override
  ConsumerState<MessageInfoScreen> createState() => _MessageInfoScreenState();
}

class _MessageInfoScreenState extends ConsumerState<MessageInfoScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final List<SavedMessage> messages = [
    const SavedMessage(
      text: 'Flutter Riverpod architecture notes',
      time: '10:24 AM',
    ),
    const SavedMessage(
      text: 'Remember to implement chat pagination.',
      time: 'Yesterday',
      isSender: true,
    ),
    const SavedMessage(text: 'https://flutter.dev', time: 'Yesterday'),
    const SavedMessage(
      text: 'Telegram clone feature checklist.',
      time: 'Monday',
    ),
    const SavedMessage(
      text: 'UI inspiration screenshots.',
      time: 'Jun 15',
      isSender: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7EBF0),

      appBar: AppBar(
        elevation: 0,
        leadingWidth: 40,

        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),

        titleSpacing: 0,

        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.orange,
              child: Text(
                widget.userName.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.userName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    "online",
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined, color: Colors.black),
          ),

          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'settings', child: Text('Archive Settings')),
              PopupMenuItem(value: 'read_all', child: Text('Mark All Read')),
            ],
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return _MessageBubble(message: message);
                },
              ),
            ),

            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                builder: (_) {
                  return GridView.builder(
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(8),
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.add), Text('data')],
                        ),
                      );
                    },
                  );
                  /* return Wrap(
                    children: [
                      ListTile(
                        leading: Icon(Icons.push_pin),
                        title: Text("Gallery"),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications_off),
                        title: Text("Camera"),
                      ),
                      ListTile(
                        leading: Icon(Icons.archive),
                        title: Text("Location"),
                      ),
                      ListTile(
                        leading: Icon(Icons.archive),
                        title: Text("Contact"),
                      ),
                      ListTile(
                        leading: Icon(Icons.archive),
                        title: Text("Document"),
                      ),
                      ListTile(
                        leading: Icon(Icons.archive),
                        title: Text("Poll"),
                      ),
                      ListTile(
                        leading: Icon(Icons.archive),
                        title: Text("Event"),
                      ),
                      ListTile(
                        leading: Icon(Icons.archive),
                        title: Text("AI Images"),
                      ),
                    ],
                  ); */
                },
              );
            },
            icon: const Icon(Icons.add_circle_outline),
          ),

          Expanded(
            child: TextField(
              controller: _messageController,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Message",

                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.emoji_emotions_outlined),
                ),

                filled: true,
                fillColor: const Color(0xffF2F4F5),

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xff229ED9),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final SavedMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isSender;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isMe ? const Color(0xffDCF8C6) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message.text, style: const TextStyle(fontSize: 15)),

                      const SizedBox(height: 4),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          message.time,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
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
