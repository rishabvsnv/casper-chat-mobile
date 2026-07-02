class FolderItem {
  final String name;
  final String description;
  final int chatCount;
  final bool isDefault;

  FolderItem({
    required this.name,
    required this.description,
    required this.chatCount,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'chatCount': chatCount,
    'isDefault': isDefault,
  };

  factory FolderItem.fromJson(Map<String, dynamic> json) {
    return FolderItem(
      name: json['name'],
      description: json['description'],
      chatCount: json['chatCount'],
      isDefault: json['isDefault'] ?? false,
    );
  }
}
