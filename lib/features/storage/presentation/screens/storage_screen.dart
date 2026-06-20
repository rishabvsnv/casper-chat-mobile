import 'package:flutter/material.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  double usedStorage = 4.8;
  double totalStorage = 16.0;

  bool autoDownloadPhotos = true;
  bool autoDownloadVideos = true;
  bool autoDownloadFiles = false;
  bool saveToGallery = true;

  String keepMedia = '1 Month';

  @override
  Widget build(BuildContext context) {
    final storagePercentage = usedStorage / totalStorage;

    return Scaffold(
      appBar: AppBar(title: const Text('Storage Usage')),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(Icons.storage_outlined, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      '${usedStorage.toStringAsFixed(1)} GB of ${totalStorage.toStringAsFixed(1)} GB used',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(value: storagePercentage),
                    const SizedBox(height: 12),
                    Text(
                      '${(storagePercentage * 100).toStringAsFixed(0)}% used',
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          _SectionHeader(title: 'STORAGE'),

          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: const Text('Clear Cache'),
            subtitle: const Text('Free up device storage'),
            trailing: const Text('2.3 GB'),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.schedule_outlined),
            title: const Text('Keep Media'),
            subtitle: Text(keepMedia),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showKeepMediaDialog(context);
            },
          ),

          const Divider(),

          _SectionHeader(title: 'AUTO DOWNLOAD'),

          SwitchListTile(
            value: autoDownloadPhotos,
            title: const Text('Photos'),
            subtitle: const Text('Automatically download photos'),
            onChanged: (value) {
              setState(() {
                autoDownloadPhotos = value;
              });
            },
          ),

          SwitchListTile(
            value: autoDownloadVideos,
            title: const Text('Videos'),
            subtitle: const Text('Automatically download videos'),
            onChanged: (value) {
              setState(() {
                autoDownloadVideos = value;
              });
            },
          ),

          SwitchListTile(
            value: autoDownloadFiles,
            title: const Text('Files'),
            subtitle: const Text('Automatically download documents'),
            onChanged: (value) {
              setState(() {
                autoDownloadFiles = value;
              });
            },
          ),

          const Divider(),

          _SectionHeader(title: 'MEDIA'),

          SwitchListTile(
            value: saveToGallery,
            title: const Text('Save to Gallery'),
            subtitle: const Text('Store downloaded media in gallery'),
            onChanged: (value) {
              setState(() {
                saveToGallery = value;
              });
            },
          ),

          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Photos'),
            subtitle: const Text('1.2 GB'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.video_library_outlined),
            title: const Text('Videos'),
            subtitle: const Text('2.8 GB'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.insert_drive_file_outlined),
            title: const Text('Files'),
            subtitle: const Text('0.8 GB'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          _SectionHeader(title: 'NETWORK'),

          ListTile(
            leading: const Icon(Icons.network_check),
            title: const Text('Data Usage'),
            subtitle: const Text('Manage mobile and Wi-Fi usage'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _showKeepMediaDialog(BuildContext context) async {
    final options = ['3 Days', '1 Week', '1 Month', 'Forever'];

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        String tempValue = keepMedia;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((option) {
                  final isSelected = tempValue == option;

                  return ListTile(
                    title: Text(option),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setModalState(() {
                        tempValue = option;
                      });

                      setState(() {
                        keepMedia = option;
                      });

                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            );
          },
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
