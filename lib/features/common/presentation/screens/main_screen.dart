import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:messenger/features/chats/presentation/screens/chat_screen.dart';
import 'package:messenger/features/common/providers/unread_count_provider.dart';
import 'package:messenger/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:messenger/features/profile/presentation/screens/profile_screen.dart';
import 'package:messenger/features/settings/presentation/screens/setting_screen.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final unreadCount = ref.watch(unreadCountProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          ChatScreen(),
          ContactsScreen(),
          SettingScreen(),
          ProfileScreen(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff229ED9),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(unreadCount.toString()),
              isLabelVisible: unreadCount > 0,
              child: const Icon(PhosphorIconsRegular.chatsCircle),
            ),
            activeIcon: Badge(
              label: Text(unreadCount.toString()),
              isLabelVisible: unreadCount > 0,
              child: const Icon(PhosphorIconsFill.chatsCircle),
            ),
            label: 'Chats',
          ),
          const BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.addressBook),
            activeIcon: Icon(PhosphorIconsFill.addressBook),
            label: 'Contacts',
          ),
          const BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.gear),
            activeIcon: Icon(PhosphorIconsFill.gear),
            label: 'Settings',
          ),
          const BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.userCircle),
            activeIcon: Icon(PhosphorIconsFill.userCircle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
