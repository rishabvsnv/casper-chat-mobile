import 'package:messenger/routes/routes_export.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final settingsRoutes = <RouteBase>[
  appRoute(NamedRoutes.settings, (_, _) => const SettingsScreen()),

  appRoute(NamedRoutes.appearance, (_, _) => const AppearanceScreen()),

  appRoute(NamedRoutes.language, (_, _) => const LanguageScreen()),

  appRoute(NamedRoutes.privacy, (_, _) => const PrivacyScreen()),

  appRoute(NamedRoutes.privacyPolicy, (_, _) => const PrivacyPolicyScreen()),

  appRoute(NamedRoutes.notifications, (_, _) => const NotificationsScreen()),

  appRoute(NamedRoutes.storage, (_, _) => const StorageScreen()),

  appRoute(NamedRoutes.devices, (_, _) => const DevicesScreen()),

  appRoute(NamedRoutes.blockedUsers, (_, _) => const BlockedUsersScreen()),

  appRoute(NamedRoutes.dataUsage, (_, _) => const DataUsageScreen()),

  appRoute(NamedRoutes.activeSessions, (_, _) => const ActiveSessionsScreen()),
];
