import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final String videoUrl;
  final String? title;

  const VideoPlayerScreen({super.key, required this.videoUrl, this.title});

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  bool _showControls = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;

    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');

    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final position = _controller.value.position;
    final duration = _controller.value.duration;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            Center(
              child: !_isInitialized
                  ? const CircularProgressIndicator()
                  : AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
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
                          widget.title ?? 'Video',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          // Todo:
                          // Share video
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
                            value: 'download',
                            child: Text(
                              'Download',
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

            if (_showControls && _isInitialized)
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    iconSize: 72,
                    onPressed: _togglePlayPause,
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: _showControls ? 0 : -120,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Slider(
                        value: duration.inMilliseconds == 0
                            ? 0
                            : position.inMilliseconds.toDouble() /
                                  duration.inMilliseconds.toDouble(),
                        onChanged: (value) {
                          final seekTo = Duration(
                            milliseconds: (duration.inMilliseconds * value)
                                .round(),
                          );

                          _controller.seekTo(seekTo);
                        },
                      ),

                      Row(
                        children: [
                          Text(
                            _formatDuration(position),
                            style: const TextStyle(color: Colors.white),
                          ),

                          const Spacer(),

                          Text(
                            _formatDuration(duration),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
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
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
