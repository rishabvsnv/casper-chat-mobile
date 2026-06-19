import 'package:flutter/material.dart';

class DashboardItem {
  final IconData icon;
  final String text;
  final String route;
  final bool disabled;
  final bool demoMode;
  final Map<String, dynamic>? extra;
  final bool hasPermission;

  DashboardItem({
    required this.icon,
    required this.text,
    required this.route,
    this.disabled = false,
    this.demoMode = false,
    this.extra,
    this.hasPermission = false,
  });
}
