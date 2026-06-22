import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final Widget? customTitle;
  final List<Widget>? actions;
  final bool isDashboard;
  final bool isCenterTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.customTitle,
    this.actions,
    this.isDashboard = false,
    this.isCenterTitle = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      actionsPadding: EdgeInsets.only(right: 16),
      title: isDashboard
          ? const Text(
              "Telegram",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xff229ED9),
              ),
            )
          : (customTitle ?? Text(title)),
      centerTitle: isCenterTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
