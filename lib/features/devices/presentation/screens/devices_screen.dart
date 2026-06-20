import 'package:flutter/material.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              .map((device) => _DeviceTile(device: device)),

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
              .map((device) => _DeviceTile(device: device)),

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

class _DeviceTile extends StatelessWidget {
  final DeviceModel device;

  const _DeviceTile({required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(_getDeviceIcon(device.platform))),
      title: Text(
        device.deviceName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${device.platform} • ${device.location}\n${device.lastActive}',
      ),
      isThreeLine: true,
      trailing: device.isCurrent
          ? const Chip(label: Text('Current'))
          : IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
    );
  }

  IconData _getDeviceIcon(String platform) {
    final value = platform.toLowerCase();

    if (value.contains('android')) {
      return Icons.android;
    }

    if (value.contains('ios') || value.contains('iphone')) {
      return Icons.phone_iphone;
    }

    if (value.contains('mac')) {
      return Icons.laptop_mac;
    }

    if (value.contains('windows')) {
      return Icons.desktop_windows;
    }

    return Icons.devices;
  }
}

class DeviceModel {
  final String deviceName;
  final String platform;
  final String location;
  final String lastActive;
  final bool isCurrent;

  const DeviceModel({
    required this.deviceName,
    required this.platform,
    required this.location,
    required this.lastActive,
    this.isCurrent = false,
  });
}
