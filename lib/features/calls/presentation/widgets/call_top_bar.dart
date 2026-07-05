import 'package:flutter/material.dart';

class CallTopBar extends StatelessWidget {
  final bool visible;
  final VoidCallback onClose;
  final VoidCallback onScreenShare;

  const CallTopBar({
    super.key,
    required this.visible,
    required this.onClose,
    required this.onScreenShare,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: visible ? 1 : 0,
      child: Row(
        children: [
          const SizedBox(width: 16),

          IconButton(
            onPressed: onClose,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),

          const Spacer(),

          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'screen_share':
                  onScreenShare();
                  break;

                case 'call_info':
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'screen_share', child: Text('Screen Share')),
              PopupMenuItem(value: 'call_info', child: Text('Call Info')),
            ],
          ),

          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
