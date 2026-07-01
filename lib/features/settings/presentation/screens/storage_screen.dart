import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/features/settings/presentation/widgets/section_header_widget.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  double cacheSizeMB = 2456;

  bool autoDownloadPhotos = true;
  bool autoDownloadVideos = true;
  bool autoDownloadFiles = false;
  bool saveToGallery = true;

  String keepMedia = '1 Month';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storage Usage')),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          // STORAGE OVERVIEW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      child: Icon(
                        Icons.storage_outlined,
                        size: 34,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      '${cacheSizeMB.toStringAsFixed(0)} MB',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Cached Media',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),

                    const SizedBox(height: 20),

                    LinearProgressIndicator(
                      value: 0.32,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '2.4 GB of 8 GB used',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          SectionHeaderWidget(title: 'STORAGE'),

          _SettingsCard(
            children: [
              ListTile(
                leading: const Icon(Icons.cleaning_services_outlined),
                title: const Text('Clear Cache'),
                subtitle: const Text('Remove downloaded temporary files'),
                trailing: Text('${cacheSizeMB.toStringAsFixed(0)} MB'),
                onTap: _showClearCacheDialog,
              ),

              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: const Text('Keep Media'),
                subtitle: Text(keepMedia),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  _showKeepMediaDialog(context);
                },
              ),
            ],
          ),

          SectionHeaderWidget(title: 'MEDIA USAGE'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Expanded(
                  child: _UsageCard(
                    icon: Icons.photo_library_outlined,
                    title: 'Photos',
                    value: '380 MB',
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: _UsageCard(
                    icon: Icons.video_library_outlined,
                    title: 'Videos',
                    value: '1.7 GB',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _UsageCard(
              icon: Icons.insert_drive_file_outlined,
              title: 'Files',
              value: '320 MB',
            ),
          ),

          SectionHeaderWidget(title: 'AUTO DOWNLOAD'),

          _SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: autoDownloadPhotos,
                title: const Text('Photos'),
                subtitle: const Text('Automatically download photos'),
                onChanged: (value) {
                  setState(() {
                    autoDownloadPhotos = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: autoDownloadVideos,
                title: const Text('Videos'),
                subtitle: const Text('Automatically download videos'),
                onChanged: (value) {
                  setState(() {
                    autoDownloadVideos = value;
                  });
                },
              ),

              const Divider(height: 1),

              SwitchListTile.adaptive(
                value: autoDownloadFiles,
                title: const Text('Files'),
                subtitle: const Text('Automatically download documents'),
                onChanged: (value) {
                  setState(() {
                    autoDownloadFiles = value;
                  });
                },
              ),
            ],
          ),

          SectionHeaderWidget(title: 'MEDIA'),

          _SettingsCard(
            children: [
              SwitchListTile.adaptive(
                value: saveToGallery,
                title: const Text('Save to Gallery'),
                subtitle: const Text('Store downloaded media in gallery'),
                onChanged: (value) {
                  setState(() {
                    saveToGallery = value;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _showClearCacheDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Clear Cache'),
          content: const Text('Are you sure you want to clear cached media?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      setState(() {
        cacheSizeMB = 0;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache cleared successfully')),
      );
    }
  }

  Future<void> _showKeepMediaDialog(BuildContext context) async {
    const options = ['3 Days', '1 Week', '1 Month', 'Forever'];

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: RadioGroup<String>(
                groupValue: keepMedia,
                onChanged: (value) {
                  setState(() {
                    keepMedia = value!;
                  });

                  context.pop();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.map((option) {
                    return RadioListTile<String>(
                      value: option,
                      title: Text(option),
                    );
                  }).toList(),
                ),
              ),
            );
          },
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

class _UsageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _UsageCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 28),

            const SizedBox(height: 10),

            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),

            const SizedBox(height: 4),

            Text(title),
          ],
        ),
      ),
    );
  }
}
