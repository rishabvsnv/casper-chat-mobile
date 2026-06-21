import 'package:flutter/material.dart';

class ChatFolder {
  final String title;
  final String description;
  final IconData icon;
  final bool isDefault;

  const ChatFolder({
    required this.title,
    required this.description,
    required this.icon,
    this.isDefault = false,
  });
}
