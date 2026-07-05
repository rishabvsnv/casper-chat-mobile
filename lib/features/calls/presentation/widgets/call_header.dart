import 'package:flutter/material.dart';
import 'package:messenger/features/calls/domain/models/call_state.dart';

class CallHeader extends StatelessWidget {
  final bool showControls;
  final Color networkColor;
  final String networkLabel;
  final String name;
  final ThemeData theme;
  final String callStatus;
  final CallState callState;
  final String callTime;

  const CallHeader({
    super.key,
    required this.showControls,
    required this.networkColor,
    required this.networkLabel,
    required this.name,
    required this.theme,
    required this.callStatus,
    required this.callState,
    required this.callTime,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: showControls ? 1 : 0,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .35),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield_outlined, size: 14, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  'Casper Secure Call',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .30),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.network_cell, size: 14, color: networkColor),
                const SizedBox(width: 6),
                Text(
                  networkLabel,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            name,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            callStatus,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),

          const SizedBox(height: 4),

          Text(
            callState == CallState.connected ? callTime : '--:--',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
