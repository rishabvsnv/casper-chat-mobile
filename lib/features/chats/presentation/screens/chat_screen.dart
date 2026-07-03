import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/features/chats/presentation/widgets/chat_search_delegate.dart';
import 'package:messenger/features/chats/providers/chat_provider.dart';
import 'package:messenger/features/folders/providers/folders_provider.dart';
// import 'package:messenger/features/chats/presentation/widgets/show_birthdays.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final PageController _pageController = PageController();
  final ScrollController _tabScrollController = ScrollController();
  int selectedTab = 0;
  final List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();

    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      showBirthdayDialog(BuildContext, context);
    }); */
  }

  void _scrollToSelectedTab(int index) {
    final context = _tabKeys[index].currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        alignment: 0.5,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(chatsProvider);
    final folders = ref.watch(foldersProvider);
    final tabs = ['All', 'Unread', ...folders.map((e) => e.name)];

    while (_tabKeys.length < tabs.length) {
      _tabKeys.add(GlobalKey());
    }

    if (selectedTab >= tabs.length) {
      selectedTab = 0;
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'camera_fab',
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.primary,
            elevation: 2,
            onPressed: () {
              context.push(NamedRoutes.camera);
            },
            child: const Icon(
              PhosphorIconsRegular.camera,
              color: Color(0xff229ED9),
            ),
          ),

          const SizedBox(height: 12),

          FloatingActionButton(
            heroTag: 'compose_fab',
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 2,
            highlightElevation: 4,
            onPressed: () {
              context.push(NamedRoutes.contacts);
            },
            child: const Icon(PhosphorIconsRegular.pen, color: Colors.white),
          ),
        ],
      ),

      appBar: CustomAppBar(
        isDashboard: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.dark_mode_outlined),
                    Text('Night Mode'),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  context.push(NamedRoutes.newGroup);
                },
                value: 'message',
                child: const Row(
                  children: [Icon(Icons.people_outlined), Text('New Group')],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  context.push(NamedRoutes.savedMessages);
                },
                value: 'remove',
                child: const Row(
                  children: [
                    Icon(Icons.bookmark_outline),
                    Text('Saved Messages'),
                  ],
                ),
              ),
            ],
          ),
          // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                /* Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 54,
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.orange,
                            ),
                            Positioned(
                              left: 18,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.purple.shade200,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Text(
                        "CasperChat",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff229ED9),
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ), */
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Hero(
                    tag: 'global_search',
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: ChatSearchDelegate(chats),
                          );
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).inputDecorationTheme.fillColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Search',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // ShowBirthdays(),
                if (tabs.length > 1)
                  Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1C1C1E)
                          : const Color(0xFFF1F1F3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView.separated(
                      controller: _tabScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 2),
                      itemBuilder: (context, index) {
                        final selected = selectedTab == index;

                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOut,
                            );
                          },
                          child: AnimatedContainer(
                            key: _tabKeys[index],
                            duration: const Duration(milliseconds: 120),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? Theme.of(context).cardColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: selected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 8),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        selectedTab = index;
                      });

                      _scrollToSelectedTab(index);
                    },
                    itemCount: tabs.length,
                    itemBuilder: (context, tabIndex) {
                      final filteredChats = tabIndex == 0
                          ? chats
                          : tabIndex == 1
                          ? chats
                                .where((chat) => (chat["unread"] as int) > 0)
                                .toList()
                          : chats
                                .where((chat) => chat["type"] == tabs[tabIndex])
                                .toList();
                      filteredChats.sort((a, b) {
                        final aPinned = a["pinned"] as bool;
                        final bPinned = b["pinned"] as bool;

                        if (aPinned == bPinned) return 0;

                        return aPinned ? -1 : 1;
                      });

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 8, bottom: 120),
                            itemCount: filteredChats.length,
                            itemBuilder: (context, index) {
                              final chat = filteredChats[index];

                              return GestureDetector(
                                onTap: () {
                                  context.push(
                                    '${NamedRoutes.chats}/$index',
                                    extra: chat['name'],
                                  );
                                },
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
                                            leading: Icon(
                                              Icons.notifications_off,
                                            ),
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    chat["name"].toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),

                                                if (chat["pinned"] as bool)
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 4,
                                                    ),
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
                                                  color: const Color(
                                                    0xff229ED9,
                                                  ),
                                                ),

                                                const SizedBox(width: 4),

                                                Expanded(
                                                  child: Text(
                                                    chat["message"].toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ),

                                                if (chat["muted"] as bool)
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 6,
                                                    ),
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
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                          ),
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
}
