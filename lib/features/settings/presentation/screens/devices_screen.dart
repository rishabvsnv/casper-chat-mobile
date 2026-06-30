import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/features/settings/domain/device_model.dart';
import 'package:messenger/features/settings/presentation/widgets/device_tile_widget.dart';

class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = [
      const DeviceModel(
        deviceName: 'Pixel 8 Pro',
        platform: 'Android',
        location: 'Bhopal, India',
        lastActive: 'Active now',
        isCurrent: true,
      ),
      const DeviceModel(
        deviceName: 'Windows PC',
        platform: 'CasperChat Desktop',
        location: 'Bhopal, India',
        lastActive: 'Today at 9:42 AM',
      ),
      const DeviceModel(
        deviceName: 'MacBook Pro',
        platform: 'macOS',
        location: 'Mumbai, India',
        lastActive: 'Yesterday at 8:15 PM',
      ),
      const DeviceModel(
        deviceName: 'iPhone 15',
        platform: 'iOS',
        location: 'Delhi, India',
        lastActive: '2 days ago',
      ),
    ];

    final currentDevice = devices.firstWhere((d) => d.isCurrent);

    final activeSessions = devices.where((d) => !d.isCurrent).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Devices')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: .75),
                  ],
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Link Desktop Device',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Scan a QR code to login on CasperChat Desktop',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${devices.length} Active Devices',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Text(
              'Manage devices logged into your account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'CURRENT DEVICE',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Icon(
                        _getDeviceIcon(currentDevice.platform),
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentDevice.deviceName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentDevice.platform,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            currentDevice.location,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Current',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'ACTIVE SESSIONS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 8),

          ...activeSessions.map((device) => DeviceTileWidget(device: device)),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: .35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.shield_outlined),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your account is active on multiple devices. '
                        'If you see an unknown device, terminate it immediately.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: () {
                _showTerminateDialog(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Terminate All Other Sessions'),
            ),
          ),
        ],
      ),
    );
  }

  static IconData _getDeviceIcon(String platform) {
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

  static Future<void> _showTerminateDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Terminate Sessions'),
          content: const Text(
            'Are you sure you want to terminate all other active sessions?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All other sessions have been terminated'),
                  ),
                );
              },
              child: const Text('Terminate'),
            ),
          ],
        );
      },
    );
  }
}
