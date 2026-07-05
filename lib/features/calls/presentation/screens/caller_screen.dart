import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger/core/theme/app_colors.dart';

enum CallState { calling, ringing, connected, reconnecting }

enum AudioRoute { speaker, earpiece, headphones }

enum NetworkQuality { excellent, good, weak }

class CallerScreen extends StatefulWidget {
  final String name;
  final bool isVideo;

  const CallerScreen({super.key, required this.name, this.isVideo = false});

  @override
  State<CallerScreen> createState() => _CallerScreenState();
}

class _CallerScreenState extends State<CallerScreen>
    with TickerProviderStateMixin {
  Duration duration = Duration.zero;

  double _previewTop = 24;
  double _previewLeft = 20;

  static const double previewWidth = 110;
  static const double previewHeight = 170;

  Timer? _timer;
  Timer? _callStateTimer;
  Timer? _controlsTimer;

  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isVideoEnabled = false;
  bool _isFrontCamera = true;
  bool _isVideoPaused = false;
  bool _isScreenSharing = false;
  bool _showControls = true;

  CallState _callState = CallState.calling;
  AudioRoute _audioRoute = AudioRoute.speaker;
  NetworkQuality _networkQuality = NetworkQuality.excellent;

  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _isVideoEnabled = widget.isVideo;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _simulateCallFlow();

    if (_isVideoEnabled) {
      _startControlsTimer();
    }
  }

  void _simulateCallFlow() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _callState = CallState.ringing;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;

        setState(() {
          _callState = CallState.connected;
        });

        _startTimer();
      });
    });

    _callStateTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (!mounted) return;

      final random = Random().nextInt(3);

      setState(() {
        _networkQuality = NetworkQuality.values[random];
      });
    });
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        duration += const Duration(seconds: 1);
      });
    });
  }

  String get callTime {
    final hours = duration.inHours;

    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');

    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }

    return '$minutes:$seconds';
  }

  String get callStatus {
    switch (_callState) {
      case CallState.calling:
        return 'Calling...';

      case CallState.ringing:
        return 'Ringing...';

      case CallState.connected:
        return 'Connected';

      case CallState.reconnecting:
        return 'Reconnecting...';
    }
  }

  String get networkLabel {
    switch (_networkQuality) {
      case NetworkQuality.excellent:
        return 'Excellent';

      case NetworkQuality.good:
        return 'Good';

      case NetworkQuality.weak:
        return 'Weak';
    }
  }

  Color get networkColor {
    switch (_networkQuality) {
      case NetworkQuality.excellent:
        return Colors.green;

      case NetworkQuality.good:
        return Colors.orange;

      case NetworkQuality.weak:
        return Colors.red;
    }
  }

  IconData get audioRouteIcon {
    switch (_audioRoute) {
      case AudioRoute.speaker:
        return Icons.volume_up_rounded;

      case AudioRoute.earpiece:
        return Icons.phone_in_talk_rounded;

      case AudioRoute.headphones:
        return Icons.headset_rounded;
    }
  }

  void _toggleMute() {
    HapticFeedback.lightImpact();

    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _toggleSpeaker() {
    HapticFeedback.lightImpact();

    setState(() {
      _isSpeakerOn = !_isSpeakerOn;
    });
  }

  void _toggleVideo() {
    HapticFeedback.lightImpact();

    setState(() {
      _isVideoEnabled = !_isVideoEnabled;
    });
  }

  void _toggleControls() {
    if (!_isVideoEnabled) return;

    setState(() {
      _showControls = !_showControls;
    });

    if (_showControls) {
      _startControlsTimer();
    }
  }

  void _switchCamera() {
    HapticFeedback.lightImpact();

    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });

    // Todo: cameraController.switchCamera();
  }

  void _toggleVideoPause() {
    HapticFeedback.lightImpact();

    setState(() {
      _isVideoPaused = !_isVideoPaused;
    });

    // Todo: enable/disable local video stream
  }

  void _toggleScreenShare() {
    HapticFeedback.lightImpact();

    setState(() {
      _isScreenSharing = !_isScreenSharing;
    });

    // Todo: start/stop screen sharing
  }

  void _snapToNearestCorner(Size size) {
    final corners = [
      Offset(20, 24), // top-left
      Offset(size.width - previewWidth - 20, 24), // top-right
      Offset(20, size.height - previewHeight - 140), // bottom-left
      Offset(
        size.width - previewWidth - 20,
        size.height - previewHeight - 140,
      ), // bottom-right
    ];

    final current = Offset(_previewLeft, _previewTop);

    Offset nearest = corners.first;
    double minDistance = double.infinity;

    for (final corner in corners) {
      final distance = (current - corner).distance;

      if (distance < minDistance) {
        minDistance = distance;
        nearest = corner;
      }
    }

    setState(() {
      _previewLeft = nearest.dx;
      _previewTop = nearest.dy;
    });
  }

  void _endCall() {
    HapticFeedback.mediumImpact();

    Navigator.pop(context);
  }

  void _startControlsTimer() {
    _controlsTimer?.cancel();

    _controlsTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;

      setState(() {
        _showControls = false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _callStateTimer?.cancel();
    _pulseController.dispose();
    _controlsTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.iconGradientStart, AppColors.iconGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              if (_isVideoEnabled)
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _toggleControls,
                    child: Container(
                      color: Colors.black,
                      child: _isVideoPaused
                          ? const Center(
                              child: Icon(
                                Icons.videocam_off,
                                color: Colors.white54,
                                size: 80,
                              ),
                            )
                          : Image.network(
                              'https://picsum.photos/300/500',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              if (_isVideoEnabled)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  top: _previewTop,
                  left: _previewLeft,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        _previewLeft += details.delta.dx;
                        _previewTop += details.delta.dy;
                      });
                    },
                    onPanEnd: (_) {
                      _snapToNearestCorner(MediaQuery.of(context).size);
                    },
                    child: Container(
                      width: 110,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withValues(alpha: .35),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .15),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Container(color: Colors.black26),

                            Center(
                              child: Image.network(
                                'https://picsum.photos/600/950',
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'You',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: _toggleVideoPause,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _isVideoPaused
                                        ? Icons.play_arrow_rounded
                                        : Icons.pause_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              if (_isVideoEnabled)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: _showControls ? 150 : -100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FloatingActionButton.small(
                      heroTag: 'audio_route',
                      backgroundColor: Colors.white.withValues(alpha: .15),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(
                                      Icons.volume_up_rounded,
                                    ),
                                    title: const Text('Speaker'),
                                    onTap: () {
                                      setState(() {
                                        _audioRoute = AudioRoute.speaker;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.phone_in_talk_rounded,
                                    ),
                                    title: const Text('Earpiece'),
                                    onTap: () {
                                      setState(() {
                                        _audioRoute = AudioRoute.earpiece;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.headset_rounded),
                                    title: const Text('Headphones'),
                                    onTap: () {
                                      setState(() {
                                        _audioRoute = AudioRoute.headphones;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(audioRouteIcon),
                    ),
                  ),
                ),

              Column(
                children: [
                  const SizedBox(height: 12),

                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: _showControls ? 1 : 0,
                    child: Row(
                      children: [
                        const SizedBox(width: 16),

                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),

                        const Spacer(),

                        PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          onSelected: (value) {
                            switch (value) {
                              case 'screen_share':
                                _toggleScreenShare();
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'screen_share',
                              child: Text('Screen Share'),
                            ),
                            const PopupMenuItem(
                              value: 'call_info',
                              child: Text('Call Info'),
                            ),
                          ],
                        ),

                        const SizedBox(width: 8),
                      ],
                    ),
                  ),

                  // const Spacer(),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: _showControls ? 1 : 0,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .35),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                size: 14,
                                color: Colors.white,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Casper Secure Call',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .30),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.network_cell,
                                size: 14,
                                color: networkColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                networkLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          widget.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          callStatus,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          _callState == CallState.connected
                              ? callTime
                              : '--:--',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  const Spacer(),

                  AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    offset: _showControls ? Offset.zero : const Offset(0, 2),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _showControls ? 1 : 0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .12),
                          borderRadius: BorderRadius.circular(36),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: .12),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _CircleCallButton(
                              icon: _isMuted
                                  ? Icons.mic_off_rounded
                                  : Icons.mic_rounded,
                              selected: _isMuted,
                              onTap: _toggleMute,
                            ),

                            if (_isVideoEnabled)
                              _CircleCallButton(
                                icon: Icons.flip_camera_android_rounded,
                                selected: false,
                                onTap: _switchCamera,
                              )
                            else
                              _CircleCallButton(
                                icon: _isSpeakerOn
                                    ? Icons.volume_up_rounded
                                    : Icons.volume_off_rounded,
                                selected: _isSpeakerOn,
                                onTap: _toggleSpeaker,
                              ),

                            _CircleCallButton(
                              icon: _isVideoEnabled
                                  ? Icons.videocam_rounded
                                  : Icons.videocam_off_rounded,
                              selected: _isVideoEnabled,
                              onTap: _toggleVideo,
                            ),

                            GestureDetector(
                              onTap: _endCall,
                              child: Container(
                                width: 62,
                                height: 62,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.error,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.error.withValues(
                                        alpha: .35,
                                      ),
                                      blurRadius: 18,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.call_end_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleCallButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _CircleCallButton({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? Colors.white : Colors.white.withValues(alpha: .15),
          border: Border.all(color: Colors.white.withValues(alpha: .12)),
        ),
        child: Icon(
          icon,
          size: 28,
          color: selected ? AppColors.primary : Colors.white,
        ),
      ),
    );
  }
}
