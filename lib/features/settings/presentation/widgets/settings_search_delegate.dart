import 'package:flutter/material.dart';
import 'package:messenger/features/settings/domain/setting_item.dart';

class SettingsSearchDelegate extends SearchDelegate {
  final List<SettingItem> items;

  SettingsSearchDelegate(this.items);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    final results = items.where((item) {
      final q = query.toLowerCase();

      return item.title.toLowerCase().contains(q) ||
          item.subtitle!.toLowerCase().contains(q);
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text('No settings found'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];

        return ListTile(
          leading: Icon(item.icon),
          title: Text(item.title),
          subtitle: Text(item.subtitle!),
          onTap: () {
            close(context, null);
            item.onTap();
          },
        );
      },
    );
  }
}
