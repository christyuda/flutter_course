class OrderEntity {
  final String id;
  final String customerId;
  final String shippingAddr;
  final String status;
  final double totalAmount;
  final List<OrderItemEntity> orderItems;

  OrderEntity({
    required this.id,
    required this.customerId,
    required this.shippingAddr,
    required this.status,
    required this.totalAmount,
    required this.orderItems,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['id'],
      customerId: json['customer_id'],
      shippingAddr: json['shipping_addr'],
      status: json['status'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      orderItems: (json['order_items'] as List)
          .map((item) => OrderItemEntity.fromJson(item))
          .toList(),
    );
  }
}

class OrderItemEntity {
  final int id;
  final String orderId;
  final String productId;
  final double price;
  final int quantity;

  OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.price,
    required this.quantity,
  });

  factory OrderItemEntity.fromJson(Map<String, dynamic> json) {
    return OrderItemEntity(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}
