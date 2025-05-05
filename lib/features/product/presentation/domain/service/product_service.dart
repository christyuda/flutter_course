import 'dart:convert';
import 'package:flutter_course/core/utils/networking_helper.dart';
import 'package:flutter_course/features/product/presentation/domain/models/product_list_response.dart';

class ProductService {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<ProductListResponse?> fetchProducts() async {
    try {
      final response = await _networkHelper.get('/api/products');

      if (response != null && response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          return ProductListResponse.fromJson(jsonResponse);
        }
      }
      return null;
    } catch (e) {
      print("Error fetch products: $e");
      return null;
    }
  }
}
