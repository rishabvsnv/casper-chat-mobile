import 'package:flutter/material.dart';

class SettingItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  SettingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}
