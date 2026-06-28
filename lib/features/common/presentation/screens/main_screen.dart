import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:messenger/features/chats/presentation/screens/chat_screen.dart';
import 'package:messenger/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:messenger/features/profile/presentation/screens/profile_screen.dart';
import 'package:messenger/features/settings/presentation/screens/setting_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: const [
              ChatScreen(),
              ContactsScreen(),
              SettingScreen(),
              ProfileScreen(),
            ],
          ),

          /// FLOATING IOS TELEGRAM STYLE NAV BAR
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              top: false,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    height: 72,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        _TabItem(
                          index: 0,
                          currentIndex: currentIndex,
                          icon: Icons.chat_bubble_outline_rounded,
                          activeIcon: Icons.chat_bubble_rounded,
                          label: "Chats",
                          onTap: (i) => setState(() => currentIndex = i),
                        ),
                        _TabItem(
                          index: 1,
                          currentIndex: currentIndex,
                          icon: Icons.people_outline_rounded,
                          activeIcon: Icons.people_rounded,
                          label: "Contacts",
                          onTap: (i) => setState(() => currentIndex = i),
                        ),
                        _TabItem(
                          index: 2,
                          currentIndex: currentIndex,
                          icon: Icons.settings_outlined,
                          activeIcon: Icons.settings,
                          label: "Settings",
                          onTap: (i) => setState(() => currentIndex = i),
                        ),
                        _TabItem(
                          index: 3,
                          currentIndex: currentIndex,
                          icon: Icons.person_outline,
                          activeIcon: Icons.person,
                          label: "You",
                          onTap: (i) => setState(() => currentIndex = i),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================
/// TAB ITEM (iOS STYLE)
/// ============================
class _TabItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Function(int) onTap;

  const _TabItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = index == currentIndex;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: selected ? 1.12 : 1.0,
                child: Icon(
                  selected ? activeIcon : icon,
                  size: 24,
                  color: selected
                      ? const Color(0xff229ED9)
                      : Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected
                      ? const Color(0xff229ED9)
                      : Colors.grey.shade500,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
