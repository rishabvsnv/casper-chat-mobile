import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class VoicePlayerScreen extends ConsumerStatefulWidget {
  final String title;
  final String senderName;
  final Duration duration;

  const VoicePlayerScreen({
    super.key,
    this.title = 'Voice Message',
    this.senderName = 'John Doe',
    this.duration = const Duration(minutes: 2, seconds: 34),
  });

  @override
  ConsumerState<VoicePlayerScreen> createState() => _VoicePlayerScreenState();
}

class _VoicePlayerScreenState extends ConsumerState<VoicePlayerScreen> {
  bool _isPlaying = false;
  double _progress = 0.35;
  double _speed = 1.0;

  final List<double> _playbackSpeeds = [0.5, 1.0, 1.5, 2.0];

  @override
  Widget build(BuildContext context) {
    final currentPosition = Duration(
      seconds: (widget.duration.inSeconds * _progress).round(),
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        actions: [
          IconButton(
            onPressed: () {
              // Todo: Share voice message
            },
            icon: const Icon(Icons.share_outlined),
          ),
          PopupMenuButton<String>(
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'download', child: Text('Download')),
              PopupMenuItem(value: 'forward', child: Text('Forward')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),

            CircleAvatar(
              radius: 50,
              child: Text(
                widget.senderName[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.senderName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              'Voice Message',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Column(
                children: [
                  const Icon(Icons.graphic_eq, size: 80),

                  const SizedBox(height: 24),

                  Slider(
                    value: _progress,
                    onChanged: (value) {
                      setState(() {
                        _progress = value;
                      });
                    },
                  ),

                  Row(
                    children: [
                      Text(_formatDuration(currentPosition)),
                      const Spacer(),
                      Text(_formatDuration(widget.duration)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 36,
                  onPressed: () {
                    // Todo: Previous
                  },
                  icon: const Icon(Icons.replay_10),
                ),

                const SizedBox(width: 12),

                FloatingActionButton.large(
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 40,
                  ),
                ),

                const SizedBox(width: 12),

                IconButton(
                  iconSize: 36,
                  onPressed: () {
                    // Todo: Next
                  },
                  icon: const Icon(Icons.forward_10),
                ),
              ],
            ),

            const SizedBox(height: 24),

            OutlinedButton.icon(
              onPressed: () async {
                final selected = await showModalBottomSheet<double>(
                  context: context,
                  showDragHandle: true,
                  builder: (_) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _playbackSpeeds
                            .map(
                              (speed) => ListTile(
                                title: Text('${speed}x'),
                                trailing: _speed == speed
                                    ? const Icon(Icons.check)
                                    : null,
                                onTap: () {
                                  Navigator.pop(context, speed);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                );

                if (selected != null) {
                  setState(() {
                    _speed = selected;
                  });
                }
              },
              icon: const Icon(Icons.speed),
              label: Text('${_speed}x Playback'),
            ),

            const Spacer(),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.download_outlined),
                    title: const Text('Download'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.forward_outlined),
                    title: const Text('Forward'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.reply_outlined),
                    title: const Text('Reply'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');

    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
}
