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
      floatingActionButton: FloatingActionButton(
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

      appBar: CustomAppBar(
        isDashboard: true,
        actions: [
          Hero(
            tag: 'global_search',
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ChatSearchDelegate(chats),
                );
              },
              icon: Icon(PhosphorIcons.magnifyingGlassBold),
            ),
          ),
          /* PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(PhosphorIconsRegular.moonStars),
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
                  children: [
                    Icon(PhosphorIconsRegular.usersThree),
                    Text('New Group'),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  context.push(NamedRoutes.savedMessages);
                },
                value: 'remove',
                child: const Row(
                  children: [
                    Icon(PhosphorIconsRegular.bookmarkSimple),
                    Text('Saved Messages'),
                  ],
                ),
              ),
            ],
          ), */
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
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
                                            leading: Icon(
                                              PhosphorIconsRegular.pushPin,
                                            ),
                                            title: Text("Pin Chat"),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              PhosphorIconsRegular.speakerSlash,
                                            ),
                                            title: Text("Mute"),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              PhosphorIconsRegular.archiveBox,
                                            ),
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
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                chat["color"] as Color,
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
                                          if (chat["pinned"] as bool)
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.ghost,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Icon(
                                                    PhosphorIcons.pushPinFill,
                                                    size: 15,
                                                    color:
                                                        chat["color"] as Color,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
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
                                            color: AppColors.unread,
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
