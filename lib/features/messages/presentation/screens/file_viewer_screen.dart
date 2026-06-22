import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class FileViewerScreen extends ConsumerWidget {
  final String fileName;
  final String fileSize;
  final String fileType;
  final DateTime? uploadedAt;

  const FileViewerScreen({
    super.key,
    this.fileName = 'Flutter Architecture Guide.pdf',
    this.fileSize = '12.4 MB',
    this.fileType = 'PDF',
    this.uploadedAt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: fileName,
        actions: [
          IconButton(
            onPressed: () {
              // Todo: Share file
            },
            icon: const Icon(Icons.share_outlined),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'download':
                  break;
                case 'save':
                  break;
                case 'delete':
                  break;
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'download', child: Text('Download')),
              PopupMenuItem(value: 'save', child: Text('Save to Device')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 24),

          Center(
            child: CircleAvatar(
              radius: 50,
              child: Icon(_getFileIcon(fileType), size: 50),
            ),
          ),

          const SizedBox(height: 24),

          Center(
            child: Text(
              fileName,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: Text(
              '$fileSize • ${fileType.toUpperCase()}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          if (uploadedAt != null) ...[
            const SizedBox(height: 4),
            Center(
              child: Text(
                uploadedAt.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],

          const SizedBox(height: 32),

          FilledButton.icon(
            onPressed: () {
              // Todo: Open file
            },
            icon: const Icon(Icons.open_in_new),
            label: const Text('Open File'),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {
              // Todo: Download file
            },
            icon: const Icon(Icons.download_outlined),
            label: const Text('Download'),
          ),

          const SizedBox(height: 24),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('File Name'),
            subtitle: Text(fileName),
          ),

          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('File Type'),
            subtitle: Text(fileType.toUpperCase()),
          ),

          ListTile(
            leading: const Icon(Icons.storage_outlined),
            title: const Text('File Size'),
            subtitle: Text(fileSize),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Share File'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Todo: Share file
            },
          ),

          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('Save to Device'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Todo: Save file
            },
          ),

          ListTile(
            leading: const Icon(Icons.forward_outlined),
            title: const Text('Forward'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Todo: Forward file
            },
          ),

          const Divider(),

          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Column(
              children: [
                Icon(_getFileIcon(fileType), size: 60),
                const SizedBox(height: 12),
                Text(
                  'Preview Not Available',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'This file type cannot be previewed inside the application.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'doc':
      case 'docx':
        return Icons.description_outlined;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart_outlined;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow_outlined;
      case 'zip':
      case 'rar':
        return Icons.folder_zip_outlined;
      case 'mp3':
      case 'wav':
        return Icons.audio_file_outlined;
      case 'mp4':
      case 'mov':
        return Icons.video_file_outlined;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'webp':
        return Icons.image_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }
}
