import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger/features/media/presentation/widgets/media_picker_sheet.dart';

enum CameraMode { live, photo, video }

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  CameraMode _cameraMode = CameraMode.photo;
  Future<void>? _initializeFuture;

  List<CameraDescription> _cameras = [];
  int _currentCameraIndex = 0;

  FlashMode _flashMode = FlashMode.off;

  bool _isRecording = false;
  bool _isLive = false;

  Timer? _recordingTimer;
  Duration _recordingDuration = Duration.zero;

  Timer? _liveTimer;
  Duration _liveDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera([int cameraIndex = 0]) async {
    try {
      _cameras = await availableCameras();

      if (_cameras.isEmpty) return;

      await _controller?.dispose();

      _currentCameraIndex = cameraIndex;

      _controller = CameraController(
        _cameras[_currentCameraIndex],
        ResolutionPreset.high,
        enableAudio: false,
      );

      _initializeFuture = _controller!.initialize();

      await _initializeFuture;

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Camera Error: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;

    final nextIndex = (_currentCameraIndex + 1) % _cameras.length;

    await _initCamera(nextIndex);
  }

  Future<void> _showMediaPickerOptions() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const MediaPickerSheet(),
    );
  }

  Future<void> _toggleFlash() async {
    if (_controller == null) return;

    try {
      _flashMode = _flashMode == FlashMode.off
          ? FlashMode.torch
          : FlashMode.off;

      await _controller!.setFlashMode(_flashMode);

      setState(() {});
    } catch (e) {
      debugPrint('Flash Error: $e');
    }
  }

  Future<void> _takePhoto() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) return;

      final image = await _controller!.takePicture();

      debugPrint('Captured: ${image.path}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo captured'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      debugPrint('Capture Error: $e');
    }
  }

  void _toggleLive() {
    if (_isLive) {
      _liveTimer?.cancel();

      setState(() {
        _isLive = false;
      });

      return;
    }

    setState(() {
      _isLive = true;
      _liveDuration = Duration.zero;
    });

    _liveTimer?.cancel();

    _liveTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        _liveDuration += const Duration(seconds: 1);
      });
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _liveTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller!.value.previewSize!.height,
          height: _controller!.value.previewSize!.width,
          child: CameraPreview(_controller!),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _circleButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
              _circleButton(
                icon: _flashMode == FlashMode.off
                    ? Icons.flash_off
                    : Icons.flash_on,
                onTap: _toggleFlash,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 140, // above shutter controls
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _modeItem('Live', CameraMode.live),
              const SizedBox(width: 24),
              _modeItem('Photo', CameraMode.photo),
              const SizedBox(width: 24),
              _modeItem('Video', CameraMode.video),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeItem(String title, CameraMode mode) {
    final selected = _cameraMode == mode;

    return GestureDetector(
      onTap: () {
        _changeMode(mode);
        /* setState(() {
          _cameraMode = mode;
        }); */
      },
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: selected ? Colors.white : Colors.white70,
          fontSize: selected ? 17 : 15,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
        child: Text(title),
      ),
    );
  }

  Widget _buildBottomControls() {
    switch (_cameraMode) {
      case CameraMode.live:
        return _buildLiveControls();

      case CameraMode.photo:
        return _buildPhotoControls();

      case CameraMode.video:
        return _buildVideoControls();
    }
  }

  Widget _buildPhotoControls() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _gelleryButton(
            icon: Icons.photo_size_select_actual,
            onTap: _showMediaPickerOptions,
          ),

          GestureDetector(
            onTap: _takePhoto,
            child: Container(
              width: 84,
              height: 84,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          _circleButton(icon: Icons.flip_camera_ios, onTap: _switchCamera),
        ],
      ),
    );
  }

  Widget _buildVideoControls() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isRecording)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _formatDuration(_recordingDuration),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _gelleryButton(
                icon: Icons.video_library,
                onTap: _showMediaPickerOptions,
              ),

              GestureDetector(
                onTap: () async {
                  if (_isRecording) {
                    await _stopRecording();
                  } else {
                    await _startRecording();
                  }
                },
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: _isRecording ? Colors.red : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: _isRecording
                      ? const Icon(Icons.stop, color: Colors.white)
                      : null,
                ),
              ),

              _circleButton(icon: Icons.flip_camera_ios, onTap: _switchCamera),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _startRecording() async {
    if (_controller == null) return;

    try {
      await _controller!.startVideoRecording();

      setState(() {
        _isRecording = true;
        _recordingDuration = Duration.zero;
      });

      _recordingTimer?.cancel();
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;

        setState(() {
          _recordingDuration += const Duration(seconds: 1);
        });
      });
    } catch (e) {
      debugPrint('Start Recording Error: $e');
    }
  }

  Future<void> _stopRecording() async {
    if (_controller == null) return;

    try {
      final video = await _controller!.stopVideoRecording();

      debugPrint('Video saved: ${video.path}');

      _recordingTimer?.cancel();

      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      debugPrint('Stop Recording Error: $e');
    }
  }

  Future<void> _changeMode(CameraMode mode) async {
    if (_cameraMode == mode) return;

    setState(() {
      _cameraMode = mode;
    });

    await _controller?.dispose();

    _controller = CameraController(
      _cameras[_currentCameraIndex],
      ResolutionPreset.high,
      enableAudio: mode == CameraMode.video,
    );

    _initializeFuture = _controller!.initialize();

    await _initializeFuture;

    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildLiveControls() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLive)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'LIVE • ${_formatDuration(_liveDuration)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _gelleryButton(
                icon: Icons.photo_library_outlined,
                onTap: _showMediaPickerOptions,
              ),

              GestureDetector(
                onTap: _toggleLive,
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 4),
                  ),
                  child: Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: _isLive ? Colors.red : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isLive ? Icons.stop : Icons.wifi_tethering,
                        color: _isLive ? Colors.white : Colors.red,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),

              _circleButton(icon: Icons.flip_camera_ios, onTap: _switchCamera),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gelleryButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: _initializeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                _buildCameraPreview(),

                _buildTopBar(),

                _buildTabBar(),

                _buildBottomControls(),
              ],
            );
          },
        ),
      ),
    );
  }
}
