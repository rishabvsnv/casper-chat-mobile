import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRoute appRoute(
  String path,
  Widget Function(BuildContext, GoRouterState) builder,
) {
  return GoRoute(path: path, builder: builder);
}
