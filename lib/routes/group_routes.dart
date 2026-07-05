import 'package:messenger/routes/routes_export.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final groupRoutes = <RouteBase>[
  appRoute(NamedRoutes.newGroup, (_, _) => const NewGroupScreen()),

  appRoute(NamedRoutes.groupWithParams, (context, state) {
    final groupId = state.pathParameters['groupId']!;
    return GroupInfoScreen(groupId: groupId);
  }),
];
