import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/features/settings/domain/device_model.dart';
import 'package:messenger/features/settings/presentation/widgets/device_tile_widget.dart';

class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = [
      DeviceModel(
        deviceName: 'Pixel 8 Pro',
        platform: 'Android',
        location: 'Bhopal, India',
        lastActive: 'Active now',
        isCurrent: true,
      ),
      DeviceModel(
        deviceName: 'Windows PC',
        platform: 'Telegram Desktop',
        location: 'Bhopal, India',
        lastActive: 'Today at 9:42 AM',
      ),
      DeviceModel(
        deviceName: 'MacBook Pro',
        platform: 'macOS',
        location: 'Mumbai, India',
        lastActive: 'Yesterday at 8:15 PM',
      ),
      DeviceModel(
        deviceName: 'iPhone 15',
        platform: 'iOS',
        location: 'Delhi, India',
        lastActive: '2 days ago',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Devices')),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Link Desktop Device'),
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'CURRENT DEVICE',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 8),

          ...devices
              .where((device) => device.isCurrent)
              .map((device) => DeviceTileWidget(device: device)),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'ACTIVE SESSIONS',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 8),

          ...devices
              .where((device) => !device.isCurrent)
              .map((device) => DeviceTileWidget(device: device)),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text('Terminate All Other Sessions'),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
