import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';

class ChatSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> chats;

  ChatSearchDelegate(this.chats);

  @override
  String get searchFieldLabel => 'Search chats';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            query = '';
          },
        ),
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
    return _buildResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResults(context);
  }

  Widget _buildResults(BuildContext context) {
    final results = chats.where((chat) {
      final name = chat["name"].toString().toLowerCase();
      final message = chat["message"].toString().toLowerCase();

      return name.contains(query.toLowerCase()) ||
          message.contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final chat = results[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: chat["color"] as Color,
            child: Text(chat["name"].toString()[0].toUpperCase()),
          ),
          title: Text(chat["name"].toString()),
          subtitle: Text(
            chat["message"].toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            close(context, null);

            context.push('${NamedRoutes.chats}/$index', extra: chat['name']);
          },
        );
      },
    );
  }
}
