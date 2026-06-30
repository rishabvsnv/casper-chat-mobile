import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:messenger/features/settings/domain/storage_stats.dart';

class StorageService {
  Future<StorageStats> load() async {
    final cacheDir = await getTemporaryDirectory();

    final cacheBytes = await _directorySize(cacheDir);

    return StorageStats(
      totalGB: 0,
      freeGB: 0,
      usedGB: 0,
      cacheMB: cacheBytes / 1024 / 1024,
    );
  }

  Future<int> _directorySize(Directory directory) async {
    int size = 0;

    if (!directory.existsSync()) {
      return size;
    }

    await for (final entity in directory.list(
      recursive: true,
      followLinks: false,
    )) {
      if (entity is File) {
        size += await entity.length();
      }
    }

    return size;
  }

  Future<void> clearCache() async {
    final dir = await getTemporaryDirectory();

    if (dir.existsSync()) {
      await dir.delete(recursive: true);
    }
  }
}
