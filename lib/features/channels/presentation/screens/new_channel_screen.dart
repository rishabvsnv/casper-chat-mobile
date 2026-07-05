import 'package:flutter/material.dart';

class NewChannelScreen extends StatefulWidget {
  const NewChannelScreen({super.key});

  @override
  State<NewChannelScreen> createState() => _NewChannelScreenState();
}

class _NewChannelScreenState extends State<NewChannelScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isPublic = true;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _createChannel() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Channel name required')));
      return;
    }

    if (_isPublic && _usernameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Username required')));
      return;
    }

    // TDLib create channel
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Channel')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.campaign,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: FloatingActionButton.small(
                      onPressed: () {
                        // Pick image
                      },
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Channel Name',
                hintText: 'Enter channel name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Describe your channel',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: RadioGroup<bool>(
                groupValue: _isPublic,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _isPublic = value;
                  });
                },
                child: Column(
                  children: const [
                    RadioListTile<bool>(
                      value: true,
                      title: Text('Public Channel'),
                      subtitle: Text('Anyone can find and join your channel.'),
                    ),
                    Divider(height: 1),
                    RadioListTile<bool>(
                      value: false,
                      title: Text('Private Channel'),
                      subtitle: Text(
                        'Only users with an invite link can join.',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (_isPublic)
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixText: 'casper.me/',
                  labelText: 'Username',
                  hintText: 'my_channel',
                  border: OutlineInputBorder(),
                ),
              ),

            if (_isPublic) const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _createChannel,
                child: const Text('Create Channel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
