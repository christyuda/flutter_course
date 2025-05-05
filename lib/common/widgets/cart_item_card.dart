import 'package:flutter/material.dart';
import 'package:flutter_course/features/product/presentation/domain/entities/product_entities.dart';
import 'package:provider/provider.dart';
import 'package:flutter_course/features/cart/presentation/provider/cart_provider.dart';

class CartItemCard extends StatelessWidget {
  final ProductEntity cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            cartItem.imageUrl!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          cartItem.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Rp ${cartItem.price}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            cartProvider.removeFromCart(cartItem);
          },
        ),
      ),
    );
  }
}
