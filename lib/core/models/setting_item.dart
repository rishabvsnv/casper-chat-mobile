class SettingItem {
  final String title;
  final String subtitle;
  final SettingType type;
  final String? url;

  const SettingItem({
    required this.title,
    required this.subtitle,
    required this.type,
    this.url,
  });
}

enum SettingType { theme, button, url }
