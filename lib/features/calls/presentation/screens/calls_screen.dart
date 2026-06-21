import 'package:flutter/material.dart';
import 'package:messenger/features/calls/domain/call_model.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  final calls = [
    CallModel(
      name: 'John Doe',
      time: 'Today, 10:24 AM',
      isIncoming: true,
      isMissed: false,
      isVideo: false,
    ),
    CallModel(
      name: 'Emma Wilson',
      time: 'Today, 09:12 AM',
      isIncoming: false,
      isMissed: false,
      isVideo: true,
    ),
    CallModel(
      name: 'Alex Johnson',
      time: 'Yesterday, 08:45 PM',
      isIncoming: true,
      isMissed: true,
      isVideo: false,
    ),
    CallModel(
      name: 'Sophia Brown',
      time: 'Yesterday, 05:10 PM',
      isIncoming: false,
      isMissed: false,
      isVideo: true,
    ),
    CallModel(
      name: 'Michael Smith',
      time: 'Monday, 11:30 AM',
      isIncoming: true,
      isMissed: false,
      isVideo: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calls'), centerTitle: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_call),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: calls.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final call = calls[index];

          return ListTile(
            leading: CircleAvatar(
              radius: 26,
              child: Text(
                call.name[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              call.name,
              style: TextStyle(
                color: call.isMissed ? Colors.red : null,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(
                  call.isIncoming ? Icons.call_received : Icons.call_made,
                  size: 16,
                  color: call.isMissed ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 4),
                Expanded(child: Text(call.time)),
              ],
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(call.isVideo ? Icons.videocam : Icons.call),
            ),
          );
        },
      ),
    );
  }
}
