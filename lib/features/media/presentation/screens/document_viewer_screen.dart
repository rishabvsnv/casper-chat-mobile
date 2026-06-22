import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class DocumentViewerScreen extends ConsumerWidget {
  final String fileName;
  final String fileSize;
  final String fileType;

  const DocumentViewerScreen({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.fileType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: fileName,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // Todo: Share file
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'download', child: Text('Download')),
              PopupMenuItem(value: 'open', child: Text('Open Externally')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),

          Center(
            child: CircleAvatar(
              radius: 50,
              child: Icon(_getFileIcon(fileType), size: 50),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              fileName,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 8),

          Text(fileSize, style: Theme.of(context).textTheme.bodyMedium),

          Text(
            fileType.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 32),

          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('Download'),
            onTap: () {
              // Todo
            },
          ),

          ListTile(
            leading: const Icon(Icons.open_in_new),
            title: const Text('Open Externally'),
            onTap: () {
              // Todo
            },
          ),

          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Share'),
            onTap: () {
              // Todo
            },
          ),

          const Divider(),

          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Preview not available.\nUse an external application to view this document.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
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
      default:
        return Icons.insert_drive_file_outlined;
    }
  }
}
