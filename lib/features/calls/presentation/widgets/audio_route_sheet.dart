import 'package:flutter/material.dart';
import 'package:messenger/features/calls/domain/models/audio_route.dart';

class AudioRouteSheet {
  static Future<void> show(
    BuildContext context, {
    required AudioRoute currentRoute,
    required ValueChanged<AudioRoute> onChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Audio Output',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),

                _AudioRouteTile(
                  icon: Icons.volume_up_rounded,
                  title: 'Speaker',
                  selected: currentRoute == AudioRoute.speaker,
                  onTap: () {
                    onChanged(AudioRoute.speaker);
                    Navigator.pop(context);
                  },
                ),

                _AudioRouteTile(
                  icon: Icons.phone_in_talk_rounded,
                  title: 'Earpiece',
                  selected: currentRoute == AudioRoute.earpiece,
                  onTap: () {
                    onChanged(AudioRoute.earpiece);
                    Navigator.pop(context);
                  },
                ),

                _AudioRouteTile(
                  icon: Icons.headset_rounded,
                  title: 'Headphones',
                  selected: currentRoute == AudioRoute.headphones,
                  onTap: () {
                    onChanged(AudioRoute.headphones);
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AudioRouteTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _AudioRouteTile({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: selected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
