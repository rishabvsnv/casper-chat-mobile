import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class AppearanceScreen extends ConsumerStatefulWidget {
  const AppearanceScreen({super.key});

  @override
  ConsumerState<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends ConsumerState<AppearanceScreen> {
  ThemeMode _themeMode = ThemeMode.system;
  double _chatTextSize = 16;

  Color _selectedAccent = Colors.blue;

  final List<Color> _accentColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Appearance'),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Text('Customize the look and feel of your messenger.'),
          ),

          const SizedBox(height: 12),

          _sectionTitle(context, 'THEME'),

          RadioGroup<ThemeMode>(
            groupValue: _themeMode,
            onChanged: (ThemeMode? value) {
              if (value == null) return;

              setState(() {
                _themeMode = value;
              });
            },
            child: Column(
              children: const [
                RadioListTile<ThemeMode>(
                  value: ThemeMode.system,
                  title: Text('System Default'),
                  subtitle: Text('Follow device settings'),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  title: Text('Light'),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  title: Text('Dark'),
                ),
              ],
            ),
          ),

          const Divider(),

          const Divider(),

          _sectionTitle(context, 'ACCENT COLOR'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _accentColors.map((color) {
                final selected = color == _selectedAccent;

                return InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    setState(() {
                      _selectedAccent = color;
                    });
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: selected
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                    ),
                    child: selected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(),

          _sectionTitle(context, 'WALLPAPER'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _wallpaperTile(
                        context,
                        color: const Color(0xFFF5F5F5),
                        label: 'Light',
                      ),
                      _wallpaperTile(
                        context,
                        color: const Color(0xFF1C1C1E),
                        label: 'Dark',
                      ),
                      _wallpaperTile(
                        context,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        ),
                        label: 'Gradient',
                      ),
                      _wallpaperTile(
                        context,
                        image: const AssetImage('assets/wallpapers/w1.jpg'),
                        label: 'Nature',
                      ),
                      _wallpaperTile(
                        context,
                        image: const AssetImage('assets/wallpapers/w2.jpg'),
                        label: 'City',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          _sectionTitle(context, 'CHAT TEXT SIZE'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Slider(
                  value: _chatTextSize,
                  min: 12,
                  max: 24,
                  divisions: 12,
                  label: _chatTextSize.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _chatTextSize = value;
                    });
                  },
                ),
                Text('Preview message text size (${_chatTextSize.toInt()} px)'),
              ],
            ),
          ),

          const Divider(),

          _sectionTitle(context, 'CHAT PREVIEW'),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Hello! This is how messages will appear.',
                      style: TextStyle(fontSize: _chatTextSize),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedAccent.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Looks great!',
                      style: TextStyle(fontSize: _chatTextSize),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          SwitchListTile(
            value: true,
            title: const Text('Animated Emojis'),
            subtitle: const Text('Play emoji animations automatically'),
            onChanged: (_) {},
          ),

          SwitchListTile(
            value: true,
            title: const Text('Reduced Motion'),
            subtitle: const Text('Minimize animations'),
            onChanged: (_) {},
          ),

          SwitchListTile(
            value: true,
            title: const Text('Auto-Night Mode'),
            subtitle: const Text('Switch to dark mode automatically'),
            onChanged: (_) {},
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Appearance settings saved')),
                );
              },
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save Changes'),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _wallpaperTile(
    BuildContext context, {
    Color? color,
    Gradient? gradient,
    ImageProvider? image,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$label wallpaper selected')),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: color,
                gradient: gradient,
                image: image != null
                    ? DecorationImage(image: image, fit: BoxFit.cover)
                    : null,
                border: Border.all(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
