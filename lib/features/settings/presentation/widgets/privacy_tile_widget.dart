import 'package:flutter/material.dart';

class PrivacyTileWidget extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const PrivacyTileWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
