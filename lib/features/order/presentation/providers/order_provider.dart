import 'package:flutter/material.dart';
import 'package:flutter_course/features/order/presentation/service/order_service.dart';
import 'package:hive/hive.dart';
import '../domain/model/order_entity.dart';

class OrderProvider with ChangeNotifier {
final box = Hive.box('authBox');
late final String token;
late final OrderService _orderService;

OrderProvider() {
  token = box.get('access_token');
  _orderService = OrderService(token);
}


  List<OrderEntity> _orders = [];
  List<OrderEntity> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _message;
  String? get message => _message;

  /// Fetch all orders
  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();

    final result = await _orderService.fetchOrders();
    _orders = result;
    _message = _orderService.message;

    _isLoading = false;
    notifyListeners();
  }

  /// Delete order by ID
  Future<bool> deleteOrder(String orderId) async {
    _isLoading = true;
    notifyListeners();

    final success = await _orderService.deleteOrder(orderId);
    if (success) {
      _orders.removeWhere((order) => order.id == orderId);
    }
    _message = _orderService.message;

    _isLoading = false;
    notifyListeners();

    return success;
  }

  /// Update order
  Future<bool> updateOrder(String orderId, Map<String, dynamic> updateData) async {
    _isLoading = true;
    notifyListeners();

    final success = await _orderService.updateOrder(orderId, updateData);
    if (success) {
      // Refresh list (biar data terbaru)
      await fetchOrders();
    }
    _message = _orderService.message;

    _isLoading = false;
    notifyListeners();

    return success;
  }
  /// Create new order
  Future<OrderEntity?> createOrder(Map<String, dynamic> orderData) async {
    _isLoading = true;
    notifyListeners();

    final newOrder = await _orderService.createOrder(orderData);
    if (newOrder != null) {
      _orders.add(newOrder); // Add ke list biar langsung muncul
    }
    _message = _orderService.message;

    _isLoading = false;
    notifyListeners();

    return newOrder;
  }
}
