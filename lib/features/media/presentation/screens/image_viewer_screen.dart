import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageViewerScreen extends ConsumerStatefulWidget {
  final String imageUrl;
  final String? title;

  const ImageViewerScreen({super.key, required this.imageUrl, this.title});

  @override
  ConsumerState<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends ConsumerState<ImageViewerScreen> {
  bool _showControls = true;

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleControls,
            child: Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 5,
                child: Hero(
                  tag: widget.imageUrl,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.broken_image_outlined,
                              color: Colors.white,
                              size: 80,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Failed to load image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: _showControls ? 0 : -120,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                color: Colors.black54,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),

                    Expanded(
                      child: Text(
                        widget.title ?? 'Photo',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        // Todo:
                        // Share image
                      },
                      icon: const Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                      ),
                    ),

                    PopupMenuButton<String>(
                      color: Colors.grey.shade900,
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'save',
                          child: Text(
                            'Save to Gallery',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'share',
                          child: Text(
                            'Share',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            bottom: _showControls ? 0 : -100,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Todo:
                        // Reply
                      },
                      icon: const Icon(
                        Icons.reply_outlined,
                        color: Colors.white,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        // Todo:
                        // Forward
                      },
                      icon: const Icon(
                        Icons.forward_outlined,
                        color: Colors.white,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        // Todo:
                        // Download
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                        color: Colors.white,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        // Todo:
                        // Info
                      },
                      icon: const Icon(Icons.info_outline, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
