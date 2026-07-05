import 'package:messenger/routes/routes_export.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final callRoutes = <RouteBase>[
  appRoute(NamedRoutes.calls, (_, _) => const CallsScreen()),

  appRoute(NamedRoutes.caller, (context, state) {
    final extra = state.extra as Map<String, dynamic>?;

    return CallerScreen(name: extra?['userName'] ?? 'Unknown');
  }),
];
