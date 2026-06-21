import 'package:flutter/material.dart';
import 'package:messenger/features/settings/domain/device_model.dart';

class DeviceTileWidget extends StatelessWidget {
  final DeviceModel device;

  const DeviceTileWidget({super.key, required this.device});

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
