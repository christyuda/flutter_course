import 'package:flutter/material.dart';
import 'package:flutter_course/core/providers/navigation_provider.dart';
import 'package:flutter_course/core/utils/constants.dart';
import 'package:flutter_course/core/utils/responsive.dart';
import 'package:flutter_course/features/cart/presentation/provider/cart_provider.dart';
import 'package:flutter_course/features/myuser/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_course/core/routing/app_routes.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final currentMenu = navigationProvider.currentMenu;
    final userProvider = Provider.of<UserProvider>(context);
    final userData = userProvider.userData;

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          // Logo
          const Text(
            "Elektroshop",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const Spacer(),

          if (!isMobile) ...[
            Row(
              children: [
              ],
            ),
            const Spacer(),
          ],

          Row(
            children: [
              if (userData != null)
                Row(
                  children: [
                    Text(
                      "Halo, ${userData.username}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {
                        userProvider.logout();
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(width: 16),
              if (!isMobile) cartIcon(context),
              if (isMobile)
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget navItem(BuildContext context, String label, String currentMenu,
      {bool isNew = false, bool isSale = false}) {
    final isActive = label == currentMenu;
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        navigationProvider.setCurrentMenu(label);

        switch (label) {
          case "Home":
            Navigator.pushNamed(context, AppRoutes.home);
            break;
          // case "Product":
          //   Navigator.pushNamed(context, AppRoutes.product);
          //   break;
          default:
            Navigator.pushNamed(context, AppRoutes.home);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            if (isNew)
              Container(
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "New",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            if (isSale)
              Container(
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Sale",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
Widget cartIcon(BuildContext context) {
  final cartProvider = Provider.of<CartProvider>(context);

  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, AppRoutes.order); // ✅ navigasi ke OrderPage
    },
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.shopping_cart_outlined),
        if (cartProvider.items.isNotEmpty)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                "${cartProvider.items.length}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
