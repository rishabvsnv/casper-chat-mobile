import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';
import 'package:messenger/shared/widgets/custom_drawer.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  int selectedTab = 0;

  final tabs = ['All', 'Groups', 'Work', 'Bots'];

  final chats = [
    {
      "name": "Saved Messages",
      "type": "All",
      "message": "IMG_420.png",
      "time": "Fri",
      "unread": 0,
      "color": Colors.blue,
      "read": true,
      "muted": false,
      "pinned": true,
    },
    {
      "name": "Emma Torreaux",
      "type": "Work",
      "message": "Bob says hi.",
      "time": "9:41",
      "unread": 0,
      "color": Colors.orange,
      "read": true,
      "muted": false,
      "pinned": false,
    },
    {
      "name": "Roberto",
      "type": "Work",
      "message": "Say hello to Emma.",
      "time": "9:41",
      "unread": 1,
      "color": Colors.green,
      "read": false,
      "muted": false,
      "pinned": false,
    },
    {
      "name": "8Bit Times",
      "type": "Groups",
      "message": "8Bit Times started a Live Stream",
      "time": "9:41",
      "unread": 4,
      "color": Colors.red,
      "read": false,
      "muted": true,
      "pinned": false,
    },
    {
      "name": "Digital Nomads",
      "type": "Groups",
      "message": "Jennie: We just reached 2,500 members",
      "time": "9:22",
      "unread": 12,
      "color": Colors.teal,
      "read": false,
      "muted": true,
      "pinned": true,
    },
    {
      "name": "Penelope",
      "message": "See you tomorrow 👋",
      "time": "9:12",
      "unread": 0,
      "color": Colors.purple,
      "read": true,
      "muted": false,
      "pinned": false,
    },
    {
      "name": "ChatGPT Bots",
      "type": "Bots",
      "message": "See you tomorrow 👋",
      "time": "9:12",
      "unread": 0,
      "color": Colors.purple,
      "read": true,
      "muted": false,
      "pinned": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredChats = selectedTab == 0
        ? chats
        : chats.where((chat) {
            return chat["type"] == tabs[selectedTab];
          }).toList();
    filteredChats.sort((a, b) {
      final aPinned = a["pinned"] as bool;
      final bPinned = b["pinned"] as bool;

      if (aPinned == bPinned) return 0;

      return aPinned ? -1 : 1;
    });
    return Scaffold(
      drawer: const CustomDrawer(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff229ED9),
        onPressed: () {},
        child: const Icon(Icons.mode_edit_outline_rounded, color: Colors.white),
      ),

      appBar: CustomAppBar(
        isDashboard: true,
        title: 'Telegram',
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 88,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: SizedBox(
                          width: 60,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xff229ED9),
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor:
                                      Colors.primaries[index %
                                          Colors.primaries.length],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                index == 0 ? 'You' : 'User',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: 42,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(
                        tabs.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = index;
                            });
                          },
                          child: _tab(tabs[index], selectedTab == index),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                Expanded(
                  child: ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];

                      return InkWell(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.push_pin),
                                    title: Text("Pin Chat"),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.notifications_off),
                                    title: Text("Mute"),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.archive),
                                    title: Text("Archive"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onTap: () {
                          context.push(
                            '${NamedRoutes.chats}/$index',
                            extra: chat['name'],
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: chat["color"] as Color,
                                child: Text(
                                  chat["name"]
                                      .toString()
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            chat["name"].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),

                                        if (chat["pinned"] as bool)
                                          const Padding(
                                            padding: EdgeInsets.only(right: 4),
                                            child: Icon(
                                              Icons.push_pin_rounded,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                          ),

                                        Text(
                                          chat["time"].toString(),
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 4),

                                    Row(
                                      children: [
                                        Icon(
                                          (chat["read"] as bool)
                                              ? Icons.done_all
                                              : Icons.done,
                                          size: 16,
                                          color: const Color(0xff229ED9),
                                        ),

                                        const SizedBox(width: 4),

                                        Expanded(
                                          child: Text(
                                            chat["message"].toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),

                                        if (chat["muted"] as bool)
                                          const Padding(
                                            padding: EdgeInsets.only(left: 6),
                                            child: Icon(
                                              Icons.volume_off_outlined,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              if ((chat["unread"] as int) > 0)
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff229ED9),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    chat["unread"].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static Widget _tab(String title, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: selected ? const Color(0xff229ED9) : Colors.grey.shade700,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          if (selected)
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: selected ? 24 : 0,
              height: 3,
            ),
        ],
      ),
    );
  }
}
