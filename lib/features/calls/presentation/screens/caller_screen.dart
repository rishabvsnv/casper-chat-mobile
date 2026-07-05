import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/features/calls/domain/models/audio_route.dart';
import 'package:messenger/features/calls/domain/models/call_state.dart';
import 'package:messenger/features/calls/domain/models/network_quality.dart';
import 'package:messenger/features/calls/presentation/widgets/audio_route_sheet.dart';
import 'package:messenger/features/calls/presentation/widgets/call_controls.dart';
import 'package:messenger/features/calls/presentation/widgets/call_header.dart';
import 'package:messenger/features/calls/presentation/widgets/call_top_bar.dart';
import 'package:messenger/features/calls/presentation/widgets/local_video_preview.dart';

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
                LocalVideoPreview(
                  isPaused: _isVideoPaused,
                  onPauseToggle: _toggleVideoPause,
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
                        AudioRouteSheet.show(
                          context,
                          currentRoute: _audioRoute,
                          onChanged: (route) {
                            setState(() {
                              _audioRoute = route;
                            });
                          },
                        );
                      },
                      child: Icon(audioRouteIcon),
                    ),
                  ),
                ),

              Column(
                children: [
                  CallTopBar(
                    visible: _showControls,
                    onClose: _endCall,
                    onScreenShare: _toggleScreenShare,
                  ),

                  CallHeader(
                    showControls: _showControls,
                    networkColor: networkColor,
                    networkLabel: networkLabel,
                    name: widget.name,
                    theme: theme,
                    callStatus: callStatus,
                    callState: _callState,
                    callTime: callTime,
                  ),

                  const Spacer(),

                  CallControls(
                    visible: _showControls,
                    isMuted: _isMuted,
                    isVideoEnabled: _isVideoEnabled,
                    onMute: _toggleMute,
                    onVideo: _toggleVideo,
                    onEndCall: _endCall,
                    isSpeakerOn: _isSpeakerOn,
                    onSwitchCamera: _switchCamera,
                    onToggleSpeaker: _toggleSpeaker,
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
