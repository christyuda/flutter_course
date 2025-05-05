import 'package:flutter/material.dart';
import 'package:flutter_course/features/product/presentation/domain/entities/product_entities.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<ProductEntity> _products = [];

  bool get isLoading => _isLoading;
  List<ProductEntity> get products => _products;

  HomeProvider() {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _products = List.generate(
      10,
      (index) => ProductEntity(
        id: index.toString(),
        name: "Produk ${index + 1}",
        price: (index + 1) * 10000,
        imageUrl: "",
        description: "Description for Produk ${index + 1}",
        category: "Category ${index % 3 + 1}",
      ),
    );

    _isLoading = false;
    notifyListeners();
  }
}
