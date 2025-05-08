import 'package:flutter/material.dart';
import 'package:flutter_course/core/providers/navigation_provider.dart';
import 'package:flutter_course/core/routing/app_routes.dart';
import 'package:flutter_course/core/utils/constants.dart';
import 'package:flutter_course/features/myuser/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MainNavigationDrawer extends StatelessWidget {
  const MainNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final currentMenu = navigationProvider.currentMenu;

    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Elektroshop",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Divider(),

            // Menu
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  // drawerItem(context, "Home", currentMenu),
                  // drawerItem(context, "Shop", currentMenu, badge: "New"),
                  // drawerItem(context, "Product", currentMenu),
                  // drawerItem(context, "Sale", currentMenu, badge: "Sale"),
                  // drawerItem(context, "Portfolio", currentMenu),
                  // drawerItem(context, "Lookbook", currentMenu),
                  // drawerItem(context, "Blog", currentMenu),
                ],
              ),
            ),

            const Divider(),

            // ✅ Tambahkan USER INFO + LOGIN/LOGOUT
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                final userData = userProvider.userData;

                if (userData != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo, ${userData.username}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            userProvider.logout();
                            Navigator.pop(context); // tutup drawer
                            Navigator.pushNamed(context, 'LoginPage'); // redirect ke login
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.login),
                          title: const Text(
                            "Masuk",
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context); // tutup drawer
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.app_registration),
                          title: const Text(
                            "Daftar",
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context); // tutup drawer
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),

            // Info Kontak
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "+01 23456789\nKalles@domain.com",
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(BuildContext context, String label, String currentMenu, {String? badge}) {
    final isActive = label == currentMenu;
    final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);

    return ListTile(
      selected: isActive,
      selectedTileColor: Colors.grey.shade200,
      title: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
          if (badge != null) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badge == "Sale" ? Colors.orange : Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        navigationProvider.setCurrentMenu(label);
        Navigator.pop(context);

        // Navigate sesuai menu
        switch (label) {
          case "Home":
            Navigator.pushNamed(context, 'HomePage');
            break;
          case "Product":
            Navigator.pushNamed(context, 'ProductPage');
            break;
          default:
            Navigator.pushNamed(context, 'HomePage');
        }
      },
    );
  }
}
