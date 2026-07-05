import 'package:messenger/routes/routes_export.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/routes/named_routes.dart';
import 'package:messenger/routes/route_helpers.dart';

final folderRoutes = <RouteBase>[
  appRoute(NamedRoutes.folders, (_, _) => const FoldersScreen()),

  appRoute(NamedRoutes.editFolder, (_, _) => const EditFolderScreen()),
];
