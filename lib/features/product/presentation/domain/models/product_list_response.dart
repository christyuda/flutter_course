import 'package:flutter_course/features/product/presentation/domain/entities/product_entities.dart';

class ProductListResponse {
  final bool success;
  final String message;
  final List<ProductEntity> products;

  ProductListResponse({
    required this.success,
    required this.message,
    required this.products,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    final productList = (json['data']['products'] as List)
        .map((e) => ProductEntity.fromJson(e))
        .toList();

    return ProductListResponse(
      success: json['success'],
      message: json['message'],
      products: productList,
    );
  }
}
