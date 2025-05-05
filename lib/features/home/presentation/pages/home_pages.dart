import 'package:flutter/material.dart';
import 'package:flutter_course/core/routing/app_routes.dart';
// import 'package:flutter_course/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_course/features/home/presentation/widgets/contact_info_bar.dart';
import 'package:flutter_course/features/home/presentation/widgets/home_carousel.dart';
import 'package:flutter_course/features/home/presentation/widgets/main_navigation_bar.dart';
import 'package:flutter_course/features/home/presentation/widgets/main_navigation_drawer.dart';
import 'package:flutter_course/features/home/presentation/widgets/top_promo_banner.dart';
import 'package:flutter_course/features/myuser/presentation/providers/user_provider.dart';
import 'package:flutter_course/features/product/presentation/providers/product_provider.dart';
import 'package:flutter_course/features/product/widgets/product_card_mini.dart';
import 'package:provider/provider.dart';
import 'package:flutter_course/core/utils/constants.dart';
import 'package:flutter_course/common/widgets/section_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUserProfile();
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const MainNavigationDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Sliver Top Promo
            SliverToBoxAdapter(child: TopPromoBanner()),

            // Sliver Contact Info Bar
            SliverToBoxAdapter(child: ContactInfoBar()),

            // Sticky Navbar
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyNavbarDelegate(child: MainNavigationBar()),
            ),

            // Content scrollable
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const HomeCarousel(),
                  const SizedBox(height: 24),
                  // const CategoryGrid(),
                  // const SizedBox(height: 24),
                  const SectionTitle(title: "Produk Terbaru"),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Consumer<ProductProvider>(
                      builder: (context, productProvider, _) {
                        final isMobile =
                            MediaQuery.of(context).size.width < 768;

                        if (productProvider.products.isEmpty) {
                          return const Center(
                            child: Text(
                              "Belum ada produk tersedia",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          );
                        }

                        if (isMobile) {
                          return SizedBox(
                            height: 250, // fix tinggi
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: productProvider.products.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final product = productProvider.products[index];
                                return ProductCardMini(product: product);
                              },
                            ),
                          );
                        } else {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productProvider.products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 140 / 220, // konsisten ratio
                            ),
                            itemBuilder: (context, index) {
                              final product = productProvider.products[index];
                              return ProductCardMini(product: product);
                            },
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tombol "Lihat Semua Produk"
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.product);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "Lihat Semua Produk",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyNavbarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyNavbarDelegate({required this.child});

  @override
  double get minExtent => 70; // Tinggi minimum
  @override
  double get maxExtent => 70; // Tinggi maksimum tetap

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Container(
        color: AppColors.background,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StickyNavbarDelegate oldDelegate) {
    return false;
  }
}
