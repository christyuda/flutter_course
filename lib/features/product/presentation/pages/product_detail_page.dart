import 'package:flutter/material.dart';
import 'package:flutter_course/core/utils/responsive.dart';
import 'package:flutter_course/features/product/presentation/domain/entities/product_entities.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Detail")),
      body: Responsive(
        mobile: _MobileView(product: product),
        desktop: _DesktopView(product: product),
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}

// ==================== DESKTOP VIEW ====================

class _DesktopView extends StatelessWidget {
  final ProductEntity product;

  const _DesktopView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _ProductImage(imageUrl: product.imageUrl)),
          const SizedBox(width: 40),
          Expanded(child: _ProductInfo(product: product)),
        ],
      ),
    );
  }
}

// ==================== MOBILE VIEW ====================

class _MobileView extends StatelessWidget {
  final ProductEntity product;

  const _MobileView({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ProductImage(imageUrl: product.imageUrl),
        const SizedBox(height: 20),
        _ProductInfo(product: product),
      ],
    );
  }
}

// ==================== IMAGE COMPONENT ====================

class _ProductImage extends StatelessWidget {
  final String? imageUrl;

  const _ProductImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl?.isNotEmpty == true
              ? imageUrl!
              : "https://dummyimage.com/640x4:3/",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ==================== INFO COMPONENT ====================

class _ProductInfo extends StatelessWidget {
  final ProductEntity product;

  const _ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Category
        Text(
          product.category.toUpperCase(),
          style: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // ✅ Name
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // ✅ Price
        Text(
          "Rp${product.price.toStringAsFixed(0)}",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // ✅ Description
        const Text(
          "Description",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 30),

        // ✅ Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}