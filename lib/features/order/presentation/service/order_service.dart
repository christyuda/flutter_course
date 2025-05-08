import 'dart:convert';
import 'package:flutter_course/core/utils/networking_helper.dart';
import '../domain/model/order_entity.dart';

class OrderService {
  String? message;
  final NetworkHelper _networkHelper;

  /// GET ALL ORDERS

  OrderService(String token) : _networkHelper = NetworkHelper(token: token);
  

  Future<List<OrderEntity>> fetchOrders() async {
    try {
      final response = await _networkHelper.get('/api/orders');

      if (response != null && response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List orders = jsonData['data'];
        return orders.map((e) => OrderEntity.fromJson(e)).toList();
      } else {
        message = 'Error server (${response?.statusCode})';
        return [];
      }
    } catch (e) {
      message = 'Terjadi kesalahan: $e';
      return [];
    }
  }

  /// DELETE ORDER
  Future<bool> deleteOrder(String orderId) async {
    try {
      final response = await _networkHelper.delete('/api/orders/$orderId');

      if (response != null && response.statusCode == 200) {
        return true;
      } else {
        message = 'Error server (${response?.statusCode})';
        return false;
      }
    } catch (e) {
      message = 'Terjadi kesalahan: $e';
      return false;
    }
  }
  /// CREATE ORDER
Future<OrderEntity?> createOrder(Map<String, dynamic> orderData) async {
  try {
    final response = await _networkHelper.post('/api/orders', orderData);

    if (response != null && response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final order = jsonData['data'];
      return OrderEntity.fromJson(order);
    } else {
      message = 'Error server (${response?.statusCode})';
      return null;
    }
  } catch (e) {
    message = 'Terjadi kesalahan: $e';
    return null;
  }
}


  /// UPDATE ORDER
  Future<bool> updateOrder(String orderId, Map<String, dynamic> updateData) async {
    try {
      final response = await _networkHelper.put('/api/orders/$orderId', updateData);

      if (response != null && response.statusCode == 200) {
        return true;
      } else {
        message = 'Error server (${response?.statusCode})';
        return false;
      }
    } catch (e) {
      message = 'Terjadi kesalahan: $e';
      return false;
    }
  }
}
