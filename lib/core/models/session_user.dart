class SessionUser {
  final String id;
  final String role;
  final String name;
  final bool hasPermissions;

  SessionUser({
    required this.id,
    required this.role,
    required this.name,
    required this.hasPermissions,
  });

  factory SessionUser.fromJson(Map<String, dynamic> json) {
    return SessionUser(
      id: json['id'].toString(),
      role: json['role'],
      name: json['name'],
      hasPermissions: json['has_permissions'] ?? false,
    );
  }
}
