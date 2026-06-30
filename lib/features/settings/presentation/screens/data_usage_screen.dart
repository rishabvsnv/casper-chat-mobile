import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';
import 'package:messenger/shared/widgets/custom_list_tile.dart';

class DataUsageScreen extends ConsumerStatefulWidget {
  const DataUsageScreen({super.key});

  @override
  ConsumerState<DataUsageScreen> createState() => _DataUsageScreenState();
}

class _DataUsageScreenState extends ConsumerState<DataUsageScreen> {
  bool useLessDataForCalls = true;
  bool autoPlayVideos = true;
  bool autoPlayGifs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Data and Storage'),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          // SUMMARY CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: Icon(
                        Icons.data_usage,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Network Usage',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Monitor mobile data, Wi-Fi usage and storage.',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          const _SectionHeader(title: 'NETWORK USAGE'),

          _SettingsCard(
            children: [
              CustomListTile(
                icon: Icons.network_cell,
                title: 'Mobile Data Usage',
                subtitle: '1.2 GB used this month',
                onTap: () {},
              ),

              const Divider(height: 1),

              CustomListTile(
                icon: Icons.wifi,
                title: 'Wi-Fi Data Usage',
                subtitle: '8.4 GB used this month',
                onTap: () {},
              ),

              const Divider(height: 1),

              CustomListTile(
                icon: Icons.public,
                title: 'Roaming Data Usage',
                subtitle: 'No roaming usage',
                onTap: () {},
              ),

              const Divider(height: 1),

              CustomListTile(
                icon: Icons.restart_alt,
                title: 'Reset Statistics',
                subtitle: 'Clear all usage statistics',
                onTap: () {
                  _showResetDialog(context);
                },
              ),
            ],
          ),

          const _SectionHeader(title: 'AUTO DOWNLOAD'),

          _SettingsCard(
            children: [
              CustomListTile(
                icon: Icons.network_cell,
                title: 'Using Mobile Data',
                subtitle: 'Photos, Videos, Files',
                onTap: () {},
              ),

              const Divider(height: 1),

              CustomListTile(
                icon: Icons.wifi,
                title: 'Using Wi-Fi',
                subtitle: 'Photos, Videos, Files',
                onTap: () {},
              ),

              const Divider(height: 1),

              CustomListTile(
                icon: Icons.public,
                title: 'When Roaming',
                subtitle: 'Disabled',
                onTap: () {},
              ),
            ],
          ),

          const _SectionHeader(title: 'CALLS'),

          _SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: useLessDataForCalls,
                title: const Text('Use Less Data'),
                subtitle: const Text('Reduce bandwidth usage during calls'),
                onChanged: (value) {
                  setState(() {
                    useLessDataForCalls = value;
                  });
                },
              ),
            ],
          ),

          const _SectionHeader(title: 'AUTOPLAY MEDIA'),

          _SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: autoPlayVideos,
                title: const Text('Autoplay Videos'),
                subtitle: const Text('Automatically play videos'),
                onChanged: (value) {
                  setState(() {
                    autoPlayVideos = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: autoPlayGifs,
                title: const Text('Autoplay GIFs'),
                subtitle: const Text('Automatically play GIF animations'),
                onChanged: (value) {
                  setState(() {
                    autoPlayGifs = value;
                  });
                },
              ),
            ],
          ),

          const _SectionHeader(title: 'STORAGE'),

          _SettingsCard(
            children: [
              CustomListTile(
                icon: Icons.storage_outlined,
                title: 'Storage Usage',
                subtitle: 'Cache size: 2.3 GB',
                onTap: () {
                  context.push(NamedRoutes.storage);
                },
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _showResetDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Reset Statistics'),
          content: const Text(
            'Are you sure you want to reset all network usage statistics?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Statistics reset successfully'),
                  ),
                );
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Column(children: children),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
