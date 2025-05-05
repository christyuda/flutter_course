import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../domain/model/order_entity.dart';
import '../../../../core/utils/responsive.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order List')),
      body: Responsive(
        mobile: _OrderListMobile(),
        desktop: _OrderListDesktop(),
      ),
    );
  }
}

// =========================
// Mobile UI → ListView
// =========================

class _OrderListMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.orders.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.orders.length,
          itemBuilder: (context, index) {
            final order = provider.orders[index];
            return _OrderCard(order: order);
          },
        );
      },
    );
  }
}

// =========================
// Desktop UI → GridView
// =========================

class _OrderListDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.orders.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(32),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Ubah jadi 3 kalau mau 3 kolom
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 2.5, // Bisa diatur rasio card-nya
          ),
          itemCount: provider.orders.length,
          itemBuilder: (context, index) {
            final order = provider.orders[index];
            return _OrderCard(order: order);
          },
        );
      },
    );
  }
}

// =========================
// Order Card (dipakai di mobile & desktop)
// =========================

class _OrderCard extends StatelessWidget {
  final OrderEntity order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context, listen: false);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Customer: ${order.customerId}'),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text('Status: '),
                _statusBadge(order.status),
              ],
            ),
            const SizedBox(height: 4),
            Text('Total: ${_formatCurrency(order.totalAmount)}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showUpdateDialog(context, order),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => provider.deleteOrder(order.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// Status Badge Widget
// =========================

Widget _statusBadge(String status) {
  Color color;
  switch (status.toLowerCase()) {
    case 'pending':
      color = Colors.orange;
      break;
    case 'confirmed':
      color = Colors.blue;
      break;
    case 'shipped':
      color = Colors.green;
      break;
    default:
      color = Colors.grey;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      status,
      style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
    ),
  );
}

// =========================
// Currency Formatter
// =========================

String _formatCurrency(double value) {
  return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(value);
}

// =========================
// Update Dialog
// =========================

void _showUpdateDialog(BuildContext context, OrderEntity order) {
  final statusController = TextEditingController(text: order.status);
  final shippingController = TextEditingController(text: order.shippingAddr);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Update Order'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: shippingController,
              decoration: const InputDecoration(labelText: 'Shipping Address'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final updatedData = {
                'customer_id': order.customerId,
                'shipping_addr': shippingController.text,
                'status': statusController.text,
                'order_items': order.orderItems.map((e) => {
                  'product_id': e.productId,
                  'quantity': e.quantity
                }).toList(),
              };

              Provider.of<OrderProvider>(context, listen: false)
                  .updateOrder(order.id, updatedData);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      );
    },
  );
}
