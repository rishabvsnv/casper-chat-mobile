import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncomingCallScreen extends ConsumerWidget {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            Text(
              'Incoming Voice Call',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),

            const SizedBox(height: 40),

            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),

            const SizedBox(height: 24),

            Text(
              'John Doe',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '+91 9876543210',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CallActionButton(
                    icon: Icons.message_outlined,
                    label: 'Message',
                    backgroundColor: Colors.blue,
                    onTap: () {
                      // Todo:
                      // Open chat
                    },
                  ),

                  _CallActionButton(
                    icon: Icons.volume_off_outlined,
                    label: 'Mute',
                    backgroundColor: Colors.orange,
                    onTap: () {
                      // Todo:
                      // Mute ringtone
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CallActionButton(
                  icon: Icons.call_end,
                  label: 'Decline',
                  backgroundColor: Colors.red,
                  size: 72,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                _CallActionButton(
                  icon: Icons.call,
                  label: 'Accept',
                  backgroundColor: Colors.green,
                  size: 72,
                  onTap: () {
                    // Todo:
                    // Accept call
                  },
                ),
              ],
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class _CallActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;
  final double size;

  const _CallActionButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(size),
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: size * 0.45),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
