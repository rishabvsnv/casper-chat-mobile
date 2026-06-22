import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class SubscribersScreen extends ConsumerStatefulWidget {
  const SubscribersScreen({super.key});

  @override
  ConsumerState<SubscribersScreen> createState() => _SubscribersScreenState();
}

class _SubscribersScreenState extends ConsumerState<SubscribersScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<SubscriberModel> _subscribers = [
    const SubscriberModel(
      id: '1',
      name: 'John Doe',
      username: '@johndoe',
      isOnline: true,
      isAdmin: true,
    ),
    const SubscriberModel(
      id: '2',
      name: 'Emma Wilson',
      username: '@emma',
      isOnline: true,
    ),
    const SubscriberModel(
      id: '3',
      name: 'Michael Smith',
      username: '@michael',
      isOnline: false,
    ),
    const SubscriberModel(
      id: '4',
      name: 'Sophia Brown',
      username: '@sophia',
      isOnline: false,
    ),
    const SubscriberModel(
      id: '5',
      name: 'Alex Johnson',
      username: '@alex',
      isOnline: true,
    ),
  ];

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSubscribers = _subscribers.where((subscriber) {
      final query = _searchQuery.toLowerCase();

      return subscriber.name.toLowerCase().contains(query) ||
          subscriber.username.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Subscribers'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo:
          // Add subscriber
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                const Icon(Icons.people_outline),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${_subscribers.length} subscribers',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search subscribers',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          Expanded(
            child: filteredSubscribers.isEmpty
                ? const _EmptySubscribersView()
                : ListView.separated(
                    itemCount: filteredSubscribers.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final subscriber = filteredSubscribers[index];

                      return ListTile(
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              child: Text(subscriber.name[0].toUpperCase()),
                            ),
                            if (subscriber.isOnline)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                subscriber.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (subscriber.isAdmin)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Admin',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Text(subscriber.username),
                        trailing: PopupMenuButton(
                          itemBuilder: (_) => const [
                            PopupMenuItem(
                              value: 'profile',
                              child: Text('View Profile'),
                            ),
                            PopupMenuItem(
                              value: 'message',
                              child: Text('Send Message'),
                            ),
                            PopupMenuItem(
                              value: 'remove',
                              child: Text('Remove'),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Todo:
                          // Open profile
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptySubscribersView extends StatelessWidget {
  const _EmptySubscribersView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_outline, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No Subscribers Found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Subscribers will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriberModel {
  final String id;
  final String name;
  final String username;
  final bool isOnline;
  final bool isAdmin;

  const SubscriberModel({
    required this.id,
    required this.name,
    required this.username,
    required this.isOnline,
    this.isAdmin = false,
  });
}
