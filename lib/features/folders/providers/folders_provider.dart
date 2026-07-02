import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:messenger/features/folders/domain/folder_item.dart';

final foldersProvider =
    StateNotifierProvider<FoldersNotifier, List<FolderItem>>(
      (ref) => FoldersNotifier(),
    );

class FoldersNotifier extends StateNotifier<List<FolderItem>> {
  FoldersNotifier() : super([]) {
    loadFolders();
  }

  Future<void> loadFolders() async {
    final box = await Hive.openBox('folders');

    final data = box.get('items', defaultValue: []);

    state = (data as List)
        .map((e) => FolderItem.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> addFolder(FolderItem folder) async {
    state = [...state, folder];
    await _save();
  }

  Future<void> removeFolder(FolderItem folder) async {
    state = state.where((e) => e.name != folder.name).toList();
    await _save();
  }

  Future<void> updateFolder(String oldName, FolderItem updated) async {
    state = state.map((folder) {
      if (folder.name == oldName) {
        return updated;
      }
      return folder;
    }).toList();

    await _save();
  }

  Future<void> _save() async {
    final box = await Hive.openBox('folders');

    await box.put('items', state.map((e) => e.toJson()).toList());
  }
}
