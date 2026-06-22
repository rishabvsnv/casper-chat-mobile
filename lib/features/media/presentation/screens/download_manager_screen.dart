import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class DownloadManagerScreen extends ConsumerStatefulWidget {
  const DownloadManagerScreen({super.key});

  @override
  ConsumerState<DownloadManagerScreen> createState() =>
      _DownloadManagerScreenState();
}

class _DownloadManagerScreenState extends ConsumerState<DownloadManagerScreen> {
  final List<DownloadItem> downloads = [
    const DownloadItem(
      id: '1',
      fileName: 'Flutter Architecture.pdf',
      fileSize: '12.4 MB',
      progress: 0.85,
      status: DownloadStatus.downloading,
      icon: Icons.picture_as_pdf_outlined,
    ),
    const DownloadItem(
      id: '2',
      fileName: 'Telegram Clone UI.zip',
      fileSize: '48.1 MB',
      progress: 0.42,
      status: DownloadStatus.downloading,
      icon: Icons.folder_zip_outlined,
    ),
    const DownloadItem(
      id: '3',
      fileName: 'Meeting Recording.mp4',
      fileSize: '126 MB',
      progress: 1.0,
      status: DownloadStatus.completed,
      icon: Icons.video_file_outlined,
    ),
    const DownloadItem(
      id: '4',
      fileName: 'Project Requirements.docx',
      fileSize: '1.2 MB',
      progress: 0.0,
      status: DownloadStatus.paused,
      icon: Icons.description_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeDownloads = downloads
        .where((e) => e.status == DownloadStatus.downloading)
        .length;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Downloads'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                const Icon(Icons.download_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '$activeDownloads active download(s)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: downloads.isEmpty
                ? const _EmptyDownloadsView()
                : ListView.separated(
                    itemCount: downloads.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = downloads[index];

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(child: Icon(item.icon)),
                        title: Text(
                          item.fileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),

                            Text(item.fileSize),

                            const SizedBox(height: 8),

                            LinearProgressIndicator(value: item.progress),

                            const SizedBox(height: 6),

                            Text(
                              _statusText(item.status),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            switch (value) {
                              case 'pause':
                                break;
                              case 'resume':
                                break;
                              case 'retry':
                                break;
                              case 'delete':
                                break;
                            }
                          },
                          itemBuilder: (_) {
                            return [
                              if (item.status == DownloadStatus.downloading)
                                const PopupMenuItem(
                                  value: 'pause',
                                  child: Text('Pause'),
                                ),
                              if (item.status == DownloadStatus.paused)
                                const PopupMenuItem(
                                  value: 'resume',
                                  child: Text('Resume'),
                                ),
                              const PopupMenuItem(
                                value: 'retry',
                                child: Text('Retry'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Remove'),
                              ),
                            ];
                          },
                        ),
                        onTap: () {
                          // Todo:
                          // Open downloaded file
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _statusText(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.downloading:
        return 'Downloading';
      case DownloadStatus.completed:
        return 'Completed';
      case DownloadStatus.paused:
        return 'Paused';
      case DownloadStatus.failed:
        return 'Failed';
    }
  }
}

class _EmptyDownloadsView extends StatelessWidget {
  const _EmptyDownloadsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.download_done_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text('No Downloads', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Downloaded files will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

enum DownloadStatus { downloading, completed, paused, failed }

class DownloadItem {
  final String id;
  final String fileName;
  final String fileSize;
  final double progress;
  final DownloadStatus status;
  final IconData icon;

  const DownloadItem({
    required this.id,
    required this.fileName,
    required this.fileSize,
    required this.progress,
    required this.status,
    required this.icon,
  });
}
