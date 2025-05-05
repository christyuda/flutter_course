import 'package:flutter/material.dart';
import 'package:flutter_course/features/product/presentation/domain/entities/product_entities.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductEntity> _items = [];

  List<ProductEntity> get items => _items;

  // int get totalPrice =>
  //     _items.fold(0, (sum, item) => sum + item.price);

  void addToCart(ProductEntity product) {
    _items.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductEntity product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
