import 'package:flutter/material.dart';

class TelegramBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int unreadChats;

  const TelegramBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.unreadChats = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      height: 74,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        NavigationDestination(
          icon: Badge(
            isLabelVisible: unreadChats > 0,
            label: Text(unreadChats > 99 ? '99+' : '$unreadChats'),
            child: const Icon(Icons.chat_bubble_outline_rounded),
          ),
          selectedIcon: Badge(
            isLabelVisible: unreadChats > 0,
            label: Text(unreadChats > 99 ? '99+' : '$unreadChats'),
            child: const Icon(Icons.chat_bubble_rounded),
          ),
          label: 'Chats',
        ),

        const NavigationDestination(
          icon: Icon(Icons.people_outline_rounded),
          selectedIcon: Icon(Icons.people_rounded),
          label: 'Contacts',
        ),

        const NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),

        NavigationDestination(
          icon: _ProfileAvatar(selected: false),
          selectedIcon: _ProfileAvatar(selected: true),
          label: 'You',
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final bool selected;

  const _ProfileAvatar({required this.selected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
        ),
        border: selected
            ? Border.all(color: theme.colorScheme.primary, width: 2)
            : null,
      ),
      child: const Center(
        child: Text(
          'R',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
