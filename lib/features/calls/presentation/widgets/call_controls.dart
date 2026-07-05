import 'package:flutter/material.dart';
import 'package:messenger/core/theme/app_colors.dart';

class CallControls extends StatelessWidget {
  final bool visible;
  final bool isMuted;
  final bool isVideoEnabled;
  final bool isSpeakerOn;
  final VoidCallback onSwitchCamera;
  final VoidCallback onToggleSpeaker;

  final VoidCallback onMute;
  final VoidCallback onVideo;
  final VoidCallback onEndCall;

  const CallControls({
    super.key,
    required this.visible,
    required this.isMuted,
    required this.isVideoEnabled,
    required this.onMute,
    required this.onVideo,
    required this.onEndCall,
    required this.isSpeakerOn,
    required this.onSwitchCamera,
    required this.onToggleSpeaker,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      offset: visible ? Offset.zero : const Offset(0, 2),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: visible ? 1 : 0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: Colors.white.withValues(alpha: .12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ControlButton(
                icon: isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                selected: isMuted,
                onTap: onMute,
              ),

              if (isVideoEnabled)
                _ControlButton(
                  icon: Icons.flip_camera_android_rounded,
                  selected: false,
                  onTap: onSwitchCamera,
                )
              else
                _ControlButton(
                  icon: isSpeakerOn
                      ? Icons.volume_up_rounded
                      : Icons.volume_off_rounded,
                  selected: isSpeakerOn,
                  onTap: onToggleSpeaker,
                ),

              _ControlButton(
                icon: isVideoEnabled
                    ? Icons.videocam_rounded
                    : Icons.videocam_off_rounded,
                selected: isVideoEnabled,
                onTap: onVideo,
              ),

              GestureDetector(
                onTap: onEndCall,
                child: Container(
                  width: 62,
                  height: 62,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.error,
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
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ControlButton({
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
        ),
        child: Icon(icon, color: selected ? AppColors.primary : Colors.white),
      ),
    );
  }
}
