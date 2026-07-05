import 'package:go_router/go_router.dart';
import 'package:messenger/routes/routes_export.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final List<RouteBase> authRoutes = [
  appRoute(NamedRoutes.splash, (_, _) => const SplashScreen()),
  appRoute(NamedRoutes.login, (_, _) => const LoginScreen()),
  appRoute(NamedRoutes.otp, (_, _) => const OtpScreen()),
];
