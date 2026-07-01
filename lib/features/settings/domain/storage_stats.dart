class StorageStats {
  final double totalGB;
  final double freeGB;
  final double usedGB;
  final double cacheMB;

  const StorageStats({
    required this.totalGB,
    required this.freeGB,
    required this.usedGB,
    required this.cacheMB,
  });
}
