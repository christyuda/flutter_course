import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        if (isMobile) {
          // MOBILE: Stack vertical
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              children: [
                _CategoryItem(
                  imagePath: 'assets/images/banner/man-product.jpg',
                  label: 'Men Fashion',
                  height: 200,
                ),
                const SizedBox(height: 12),
                _CategoryItem(
                  imagePath: 'assets/images/banner/BestTravelAccessories.jpg',
                  label: 'Accessories',
                  height: 150,
                ),
                const SizedBox(height: 12),
                _CategoryItem(
                  imagePath: 'assets/images/banner/urban-shoes.jpg',
                  label: 'Footwear',
                  height: 150,
                ),
                const SizedBox(height: 12),
                _CategoryItem(
                  imagePath: 'assets/images/banner/watch-classic.jpg',
                  label: 'Watches',
                  height: 180,
                ),
              ],
            ),
          );
        } else {
          // TABLET/DESKTOP: Grid horizontal
          return Padding(
            padding: const EdgeInsets.all(90),
            child: SizedBox(
              height: 360,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: _CategoryItem(
                      imagePath: 'assets/images/banner/man-product.jpg',
                      label: 'Men Fashion',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: _CategoryItem(
                            imagePath: 'assets/images/banner/BestTravelAccessories.jpg',
                            label: 'Accessories',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: _CategoryItem(
                            imagePath: 'assets/images/banner/urban-shoes.jpg',
                            label: 'Footwear',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: _CategoryItem(
                      imagePath: 'assets/images/banner/watch-classic.jpg',
                      label: 'Watches',
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final double? height; // (optional) khusus untuk mode mobile

  const _CategoryItem({
    required this.imagePath,
    required this.label,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: height,
      ),
    );

    return Stack(
      children: [
        height != null
            ? SizedBox(
                height: height,
                child: image,
              )
            : Positioned.fill(child: image),
        Positioned(
          bottom: 12,
          left: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
