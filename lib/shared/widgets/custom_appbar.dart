import 'package:flutter/material.dart';
import 'package:messenger/core/extensions/localization_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  final bool isDashboard;
  final bool centerTitle;

  final Color? backgroundColor;
  final double elevation;
  final EdgeInsetsGeometry? actionsPadding;
  final TextStyle? titleStyle;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.bottom,
    this.isDashboard = false,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation = 0,
    this.actionsPadding,
    this.titleStyle,
  }) : assert(
         title != null || titleWidget != null || isDashboard,
         'Provide either title, titleWidget, or enable isDashboard.',
       );

  @override
  Widget build(BuildContext context) {
    Widget appBarTitle;

    if (isDashboard) {
      appBarTitle = Text(
        context.l10n.appName,
        style:
            titleStyle ??
            const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF229ED9),
            ),
      );
    } else {
      appBarTitle = titleWidget ?? Text(title!, style: titleStyle);
    }

    return AppBar(
      leading: leading,
      title: appBarTitle,
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
      elevation: elevation,
      backgroundColor: backgroundColor,
      actionsPadding: actionsPadding ?? const EdgeInsets.only(right: 16),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
