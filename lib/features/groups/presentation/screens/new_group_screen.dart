import 'package:flutter/material.dart';
import 'package:messenger/features/groups/domain/contact_model.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  final List<ContactModel> _contacts = [
    const ContactModel(id: '1', name: 'John Doe'),
    const ContactModel(id: '2', name: 'Emma Wilson'),
    const ContactModel(id: '3', name: 'Michael Smith'),
    const ContactModel(id: '4', name: 'Sophia Brown'),
    const ContactModel(id: '5', name: 'Alex Johnson'),
    const ContactModel(id: '6', name: 'Olivia Taylor'),
    const ContactModel(id: '7', name: 'Daniel Thomas'),
  ];

  final Set<String> _selectedUsers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedUsers.isEmpty
              ? 'New Group'
              : '${_selectedUsers.length} selected',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectedUsers.isEmpty
            ? null
            : () {
                // Navigate to group info screen
              },
        child: const Icon(Icons.arrow_forward),
      ),
      body: Column(
        children: [
          if (_selectedUsers.isNotEmpty)
            Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedUsers.length,
                itemBuilder: (context, index) {
                  final selectedId = _selectedUsers.elementAt(index);

                  final user = _contacts.firstWhere((e) => e.id == selectedId);

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(radius: 24, child: Text(user.name[0])),
                            Positioned(
                              right: -4,
                              top: -4,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedUsers.remove(user.id);
                                  });
                                },
                                child: const CircleAvatar(
                                  radius: 10,
                                  child: Icon(Icons.close, size: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 60,
                          child: Text(
                            user.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          Expanded(
            child: ListView.separated(
              itemCount: _contacts.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final contact = _contacts[index];

                final isSelected = _selectedUsers.contains(contact.id);

                return ListTile(
                  leading: CircleAvatar(child: Text(contact.name[0])),
                  title: Text(contact.name),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedUsers.remove(contact.id);
                      } else {
                        _selectedUsers.add(contact.id);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
