import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAccountScreen extends ConsumerStatefulWidget {
  const MyAccountScreen({super.key});

  @override
  ConsumerState<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends ConsumerState<MyAccountScreen> {
  bool _isEditing = false;

  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: 'Rishabh');
    _usernameController = TextEditingController(text: '@rishabvsnv');
    _phoneController = TextEditingController(text: '+91 9876543210');
    _bioController = TextEditingController(text: 'Building CasperChat 🚀');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });

    if (!_isEditing) {
      // Save profile
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _toggleEdit,
            icon: Icon(_isEditing ? Icons.check_rounded : Icons.edit_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          const SizedBox(height: 12),

          // PROFILE HERO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 54,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          child: Text(
                            _nameController.text.isNotEmpty
                                ? _nameController.text[0].toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: theme.colorScheme.primary,
                            child: IconButton(
                              iconSize: 16,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    if (_isEditing)
                      TextField(
                        controller: _nameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(labelText: 'Name'),
                      )
                    else
                      Text(
                        _nameController.text,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                    const SizedBox(height: 8),

                    if (_isEditing)
                      TextField(
                        controller: _usernameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                      )
                    else
                      Text(
                        _usernameController.text,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                    const SizedBox(height: 8),

                    if (_isEditing)
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                        ),
                      )
                    else
                      Text(
                        _phoneController.text,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Text(
                        'Online',
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

          const SizedBox(height: 12),

          // QUICK ACTIONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionItem(
                      icon: Icons.qr_code_2,
                      label: 'QR',
                      onTap: () {},
                    ),
                    _ActionItem(
                      icon: Icons.share_outlined,
                      label: 'Share',
                      onTap: () {},
                    ),
                    _ActionItem(icon: Icons.link, label: 'Link', onTap: () {}),
                    _ActionItem(
                      icon: Icons.badge_outlined,
                      label: 'Profile',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // STATS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Expanded(
                  child: _StatCard(value: '248', title: 'Chats'),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(value: '14', title: 'Groups'),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(value: '3.4 GB', title: 'Media'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _SectionTitle('ACCOUNT'),

          _InfoCard(
            children: [
              _EditableTile(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                value: _phoneController.text,
              ),
              _EditableTile(
                icon: Icons.alternate_email,
                title: 'Username',
                value: _usernameController.text,
              ),
            ],
          ),

          const SizedBox(height: 16),

          _SectionTitle('BIO'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _isEditing
                    ? TextField(
                        controller: _bioController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Tell people about yourself',
                        ),
                      )
                    : Text(
                        _bioController.text,
                        style: const TextStyle(fontSize: 15),
                      ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          _SectionTitle('SECURITY'),

          _InfoCard(
            children: const [
              _EditableTile(
                icon: Icons.lock_outline,
                title: 'Two-Step Verification',
                value: 'Disabled',
              ),
              _EditableTile(
                icon: Icons.devices_outlined,
                title: 'Active Sessions',
                value: '2 Devices',
              ),
            ],
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton.tonalIcon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            CircleAvatar(radius: 22, child: Icon(icon)),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String title;

  const _StatCard({required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(elevation: 0, child: Column(children: children)),
    );
  }
}

class _EditableTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _EditableTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
