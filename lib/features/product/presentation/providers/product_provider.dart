import 'package:flutter/material.dart';
import 'package:flutter_course/features/product/presentation/domain/entities/product_entities.dart';
import 'package:flutter_course/features/product/presentation/domain/service/product_service.dart';
import 'package:hive/hive.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductEntity> _products = [];
  List<ProductEntity> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _productService.fetchProducts();
      if (response != null && response.success) {
        _products = response.products;

        // ✅ Simpan ke Hive
        final box = await Hive.openBox('productBox');
        await box.put('products', _products.map((e) => e.toJson()).toList());
      } else {
        print("Gagal ambil product / response null");
      }
    } catch (e) {
      print("Error fetchProducts di provider: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadProductsFromCache() async {
    final box = await Hive.openBox('productBox');
    final cached = box.get('products') as List<dynamic>?;

    if (cached != null) {
      _products = cached.map((e) => ProductEntity.fromJson(Map<String, dynamic>.from(e))).toList();
      notifyListeners();
    }
  }
}
