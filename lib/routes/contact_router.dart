import 'package:messenger/routes/routes_export.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final contactRoutes = <RouteBase>[
  appRoute(NamedRoutes.contacts, (_, _) => const ContactsScreen()),

  appRoute(NamedRoutes.contactWithParams, (context, state) {
    final userId = state.pathParameters['userId']!;
    return ContactProfileScreen(userId: userId);
  }),

  appRoute(NamedRoutes.peopleNearby, (_, _) => const PeopleNearbyScreen()),
];
