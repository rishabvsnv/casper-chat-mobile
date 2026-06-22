import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class ActiveSessionsScreen extends ConsumerStatefulWidget {
  const ActiveSessionsScreen({super.key});

  @override
  ConsumerState<ActiveSessionsScreen> createState() =>
      _ActiveSessionsScreenState();
}

class _ActiveSessionsScreenState extends ConsumerState<ActiveSessionsScreen> {
  final List<SessionModel> sessions = [
    const SessionModel(
      id: '1',
      deviceName: 'Samsung Galaxy S24',
      platform: 'Android',
      location: 'Bhopal, India',
      ipAddress: '192.168.1.10',
      lastActive: 'Active now',
      isCurrentSession: true,
      icon: Icons.phone_android,
    ),
    const SessionModel(
      id: '2',
      deviceName: 'Windows PC',
      platform: 'Windows',
      location: 'Mumbai, India',
      ipAddress: '103.25.12.90',
      lastActive: '5 minutes ago',
      icon: Icons.computer,
    ),
    const SessionModel(
      id: '3',
      deviceName: 'MacBook Pro',
      platform: 'macOS',
      location: 'Delhi, India',
      ipAddress: '49.205.120.14',
      lastActive: '1 hour ago',
      icon: Icons.laptop_mac,
    ),
    const SessionModel(
      id: '4',
      deviceName: 'iPhone 15',
      platform: 'iOS',
      location: 'Bangalore, India',
      ipAddress: '157.48.211.76',
      lastActive: 'Yesterday',
      icon: Icons.phone_iphone,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentSession = sessions.firstWhere(
      (session) => session.isCurrentSession,
    );

    final otherSessions = sessions
        .where((session) => !session.isCurrentSession)
        .toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Active Sessions'),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Row(
              children: [
                Icon(Icons.security_outlined),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Manage devices that are currently logged into your account.',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'CURRENT SESSION',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          _SessionTile(session: currentSession, showActions: false),

          const Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'OTHER SESSIONS',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          if (otherSessions.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: Text('No other active sessions.')),
            ),

          ...otherSessions.map(
            (session) => _SessionTile(
              session: session,
              showActions: true,
              onTerminate: () {
                setState(() {
                  sessions.removeWhere((s) => s.id == session.id);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${session.deviceName} terminated')),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _showTerminateAllDialog(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Terminate All Other Sessions'),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showTerminateAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Terminate All Sessions'),
          content: const Text(
            'This will log out all other devices except your current one.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  sessions.removeWhere((session) => !session.isCurrentSession);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All other sessions terminated'),
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

class _SessionTile extends StatelessWidget {
  final SessionModel session;
  final bool showActions;
  final VoidCallback? onTerminate;

  const _SessionTile({
    required this.session,
    this.showActions = false,
    this.onTerminate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(session.icon)),
      title: Text(
        session.deviceName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(session.platform),
          Text(session.location),
          Text(
            session.lastActive,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      isThreeLine: true,
      trailing: showActions
          ? PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'terminate') {
                  onTerminate?.call();
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: 'terminate',
                  child: Text('Terminate Session'),
                ),
              ],
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.15),
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
    );
  }
}

class SessionModel {
  final String id;
  final String deviceName;
  final String platform;
  final String location;
  final String ipAddress;
  final String lastActive;
  final bool isCurrentSession;
  final IconData icon;

  const SessionModel({
    required this.id,
    required this.deviceName,
    required this.platform,
    required this.location,
    required this.ipAddress,
    required this.lastActive,
    required this.icon,
    this.isCurrentSession = false,
  });
}
