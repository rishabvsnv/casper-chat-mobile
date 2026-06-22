import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

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
          const SizedBox(height: 8),

          _SectionHeader(title: 'NETWORK USAGE'),

          ListTile(
            leading: const Icon(Icons.network_cell),
            title: const Text('Mobile Data Usage'),
            subtitle: const Text('1.8 GB sent, 6.4 GB received'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.wifi),
            title: const Text('Wi-Fi Data Usage'),
            subtitle: const Text('4.2 GB sent, 18.5 GB received'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('Roaming Data Usage'),
            subtitle: const Text('0 MB sent, 0 MB received'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.restart_alt),
            title: const Text('Reset Statistics'),
            subtitle: const Text('Clear all network usage statistics'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showResetDialog(context);
            },
          ),

          const Divider(),

          _SectionHeader(title: 'AUTO DOWNLOAD MEDIA'),

          ListTile(
            leading: const Icon(Icons.network_cell),
            title: const Text('Using Mobile Data'),
            subtitle: const Text('Photos, Videos, Files'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.wifi),
            title: const Text('Using Wi-Fi'),
            subtitle: const Text('Photos, Videos, Files'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('When Roaming'),
            subtitle: const Text('Disabled'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          _SectionHeader(title: 'CALLS'),

          SwitchListTile(
            value: useLessDataForCalls,
            title: const Text('Use Less Data for Calls'),
            subtitle: const Text('Reduce bandwidth usage during voice calls'),
            onChanged: (value) {
              setState(() {
                useLessDataForCalls = value;
              });
            },
          ),

          const Divider(),

          _SectionHeader(title: 'AUTOPLAY MEDIA'),

          SwitchListTile(
            value: autoPlayVideos,
            title: const Text('Autoplay Videos'),
            subtitle: const Text('Automatically play videos in chats'),
            onChanged: (value) {
              setState(() {
                autoPlayVideos = value;
              });
            },
          ),

          SwitchListTile(
            value: autoPlayGifs,
            title: const Text('Autoplay GIFs'),
            subtitle: const Text('Automatically play GIF animations'),
            onChanged: (value) {
              setState(() {
                autoPlayGifs = value;
              });
            },
          ),

          const Divider(),

          _SectionHeader(title: 'STORAGE'),

          ListTile(
            leading: const Icon(Icons.storage_outlined),
            title: const Text('Storage Usage'),
            subtitle: const Text('Manage cache and downloaded media'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push(NamedRoutes.storage);
            },
          ),

          const SizedBox(height: 24),
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

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
