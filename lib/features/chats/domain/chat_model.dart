import 'dart:ui';

class ChatModel {
  final String name;
  final String message;
  final String time;
  final int unread;
  final Color color;
  final bool read;
  final bool muted;
  final bool pinned;

  const ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.color,
    required this.read,
    required this.muted,
    required this.pinned,
  });
}
