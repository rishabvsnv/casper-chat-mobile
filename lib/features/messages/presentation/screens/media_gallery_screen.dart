import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class MediaGalleryScreen extends ConsumerStatefulWidget {
  final String mediaId;

  const MediaGalleryScreen({super.key, required this.mediaId});

  @override
  ConsumerState<MediaGalleryScreen> createState() => _MediaGalleryScreenState();
}

class _MediaGalleryScreenState extends ConsumerState<MediaGalleryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<MediaItem> photos = List.generate(
    18,
    (index) => MediaItem(
      id: '$index',
      type: MediaType.photo,
      title: 'Photo ${index + 1}',
    ),
  );

  final List<MediaItem> videos = List.generate(
    8,
    (index) => MediaItem(
      id: 'video_$index',
      type: MediaType.video,
      title: 'Video ${index + 1}',
      duration: '0${index + 1}:2$index',
    ),
  );

  final List<MediaItem> files = List.generate(
    12,
    (index) => MediaItem(
      id: 'file_$index',
      type: MediaType.file,
      title: 'Document_${index + 1}.pdf',
      size: '${(index + 1) * 2}.4 MB',
    ),
  );

  final List<MediaItem> links = List.generate(
    6,
    (index) => MediaItem(
      id: 'link_$index',
      type: MediaType.link,
      title: 'https://example.com/article-${index + 1}',
    ),
  );

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shared Media',
        actions: [
          IconButton(
            onPressed: () {
              // Todo:
              // Search media
            },
            icon: const Icon(Icons.search),
          ),
        ],
        /* bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Media'),
            Tab(text: 'Videos'),
            Tab(text: 'Files'),
            Tab(text: 'Links'),
          ],
        ), */
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMediaGrid(photos),
          _buildVideosGrid(videos),
          _buildFilesList(files),
          _buildLinksList(links),
        ],
      ),
    );
  }

  Widget _buildMediaGrid(List<MediaItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return InkWell(
          onTap: () {
            // Todo:
            // Open ImageViewerScreen
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 50,
                  color: Colors.grey.shade600,
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    color: Colors.black54,
                    child: Text(
                      item.title,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideosGrid(List<MediaItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return InkWell(
          onTap: () {
            // Todo:
            // Open VideoPlayerScreen
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                const Center(child: Icon(Icons.play_circle_outline, size: 60)),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(item.duration ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilesList(List<MediaItem> items) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.description_outlined)),
          title: Text(item.title),
          subtitle: Text(item.size ?? ''),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Todo:
            // Open FileViewerScreen
          },
        );
      },
    );
  }

  Widget _buildLinksList(List<MediaItem> items) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.link)),
          title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
          trailing: const Icon(Icons.open_in_new),
          onTap: () {
            // Todo:
            // Open URL
          },
        );
      },
    );
  }
}

enum MediaType { photo, video, file, link }

class MediaItem {
  final String id;
  final MediaType type;
  final String title;
  final String? duration;
  final String? size;

  const MediaItem({
    required this.id,
    required this.type,
    required this.title,
    this.duration,
    this.size,
  });
}

/* class MediaGalleryScreen extends ConsumerWidget {
  final String mediaId;
  const MediaGalleryScreen({super.key, required this.mediaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Telegram'),
      body: Center(child: Text('Telegram')),
    );
  }
}
 */
