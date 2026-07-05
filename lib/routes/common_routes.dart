import 'package:messenger/routes/routes_export.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final commonRoutes = <RouteBase>[
  appRoute(NamedRoutes.main, (_, _) => const MainScreen()),

  appRoute(NamedRoutes.camera, (_, _) => const CameraScreen()),

  appRoute(NamedRoutes.archive, (_, _) => const ArchivedChatsScreen()),

  appRoute(NamedRoutes.profile, (_, _) => const ProfileScreen()),

  appRoute(NamedRoutes.myQR, (_, _) => const QrCodeScreen()),

  appRoute(NamedRoutes.askQues, (_, _) => const AskQuestionScreen()),

  appRoute(NamedRoutes.casperChatFaqs, (_, _) => const CasperchatFaqScreen()),

  appRoute(
    NamedRoutes.casperChatFeatures,
    (_, _) => const CasperchatFeaturesScreen(),
  ),

  appRoute(NamedRoutes.myAccount, (_, _) => const MyAccountScreen()),

  appRoute(NamedRoutes.share, (_, _) => const ShareScreen()),
];
