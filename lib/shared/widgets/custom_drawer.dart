import 'package:flutter/material.dart';
import 'package:messenger/core/theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            padding: EdgeInsetsGeometry.all(0),
            child: UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColors.onPrimary,
                foregroundColor: AppColors.textPrimary,
                child: Text('P. Avatar'),
              ),
              accountName: Text('accountName'),
              accountEmail: Text('accountEmail'),
            ),
          ),
          ListBody(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text('data'),
                onTap: () {
                  Navigator.pop(context);
                  /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      ); */
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('data'),
                onTap: () {
                  Navigator.pop(context);
                  /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      ); */
                },
              ),
            ],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('asd'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
/* import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myschoolio/providers/app_version_provider.dart';
import 'package:myschoolio/providers/drawer_user_provider.dart';
import 'package:myschoolio/core/models/child_model.dart';
import 'package:myschoolio/widgets/app_circle_avatar.dart';
import 'package:myschoolio/widgets/logout_button.dart';
import 'package:myschoolio/widgets/user_name_display.dart';

/// ---------------------------------------------------------------------------
/// Drawer Widget
/// ---------------------------------------------------------------------------
class CustomDrawer extends ConsumerWidget {
  final Child? selectedChild;
  final VoidCallback? onSwitchChild;

  const CustomDrawer({super.key, this.selectedChild, this.onSwitchChild});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(drawerUserProvider);
    final appVersionText = ref.watch(appVersionTextProvider);

    final appBarColor =
        Theme.of(context).appBarTheme.backgroundColor ??
        Theme.of(context).colorScheme.primary;
    final foregroundColor =
        Theme.of(context).appBarTheme.foregroundColor ??
        Theme.of(context).colorScheme.onPrimary;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: appBarColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    AppCircleAvatar(
                      isAvatar: true,
                      radius: 35,
                      imageUrl: user.photoUrl,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 180, child: UsernameDisplay()),
                        Text(
                          'Role: ${user.role}',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: foregroundColor),
                        ),
                        SizedBox(
                          width: 180,
                          child: Tooltip(
                            message: user.schoolName,
                            child: Text(
                              user.schoolName,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: foregroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          ..._getDrawerOptions(context, user.role, user.showPatrakReport),

          _buildTile(context, Icons.info, 'About School', '/about_school'),
          _buildTile(context, Icons.settings, 'Setting', '/app_setting'),
          const LogoutButton(title: 'Logout'),

          const Divider(),

          Center(child: Text(appVersionText)),
        ],
      ),
    );
  }

  /// -------------------------------------------------------------------------
  /// Drawer Options
  /// -------------------------------------------------------------------------

  List<Widget> _getDrawerOptions(
    BuildContext context,
    String role,
    bool showPatrakReport,
  ) {
    switch (role) {
      case 'superadmin':
        return _superadminDrawer(context);
      case 'admin':
        return _adminDrawer(context, showPatrakReport);
      case 'teacher':
        return _teacherDrawer(context);
      case 'accountant':
        return _accountantDrawer(context);
      case 'receptionist':
        return _receptionistDrawer(context);
      case 'librarian':
        return _librarianDrawer(context);
      case 'parent':
        return _parentDrawer(context);
      case 'student':
        return _studentDrawer(context);
      case 'securityguard':
        return _securityguardDrawer(context);
      default:
        return _guestDrawer(context);
    }
  }

  ListTile _buildTile(
    BuildContext context,
    IconData icon,
    String title,
    String route, {
    bool popInstead = false,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        popInstead ? context.pop() : context.push(route);
      },
    );
  }

  /// -------------------------------------------------------------------------
  /// Drawer Role Sections
  /// -------------------------------------------------------------------------

  List<Widget> _superadminDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    // _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
  ];

  List<Widget> _adminDrawer(BuildContext context, bool showPatrakReport) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
  ];

  List<Widget> _teacherDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    // _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
  ];

  List<Widget> _accountantDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    // _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
  ];

  List<Widget> _receptionistDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    // _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
  ];

  List<Widget> _librarianDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    // _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
    _buildTile(
      context,
      Icons.library_books,
      'Library Management',
      '/library_management',
    ),
    _buildTile(context, Icons.book_online, 'Issued Books', '/issued_books'),
  ];

  List<Widget> _parentDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
  ];

  List<Widget> _studentDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
  ];

  List<Widget> _securityguardDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
  ];

  List<Widget> _guestDrawer(BuildContext context) => [
    _buildTile(context, Icons.home, 'Home', '/', popInstead: true),
    _buildTile(context, Icons.account_circle, 'Profile', '/profile'),
  ];
}
 */