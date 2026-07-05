import 'package:messenger/routes/routes_export.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final channelRoutes = <RouteBase>[
  appRoute(NamedRoutes.newChannel, (_, _) => const NewChannelScreen()),

  appRoute(NamedRoutes.channelWithParams, (context, state) {
    final channelId = state.pathParameters['channelId']!;
    return ChannelInfoScreen(channelId: channelId);
  }),
];
