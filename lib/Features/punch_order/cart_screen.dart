import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart' show PersistentShoppingCart;

class CartScreen extends StatefulWidget {
  final VoidCallback? onChange;
  const CartScreen({super.key, this.onChange});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // We rely on the plugin's widgets (showCartItems) which listen to changes;
  // but we also provide setState after operations to be safe.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), actions: [
        TextButton(
          onPressed: () {
            PersistentShoppingCart().clearCart();
            widget.onChange?.call();
            setState(() {});
          },
          child: const Text('Clear', style: TextStyle(color: Colors.white)),
        )
      ]),
      body: PersistentShoppingCart().showCartItems(
        cartItemsBuilder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: cartItems.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              // item is PersistentShoppingCartItem
              return ListTile(
                leading: (item.productThumbnail != null && item.productThumbnail!.isNotEmpty)
                    ? Image.asset(item.productThumbnail!, width: 55, height: 55, fit: BoxFit.cover)
                    : const SizedBox(width: 55, height: 55),
                title: Text(item.productName),
                subtitle: Text('Unit: \$${item.unitPrice.toStringAsFixed(2)}'),
                trailing: SizedBox(
                  width: 160,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () async {
                          if (item.quantity <= 1) {
                            await PersistentShoppingCart().removeFromCart(item.productId);
                          } else {
                            await PersistentShoppingCart().decrementCartItemQuantity(item.productId);
                          }
                          widget.onChange?.call();
                          setState(() {});
                        },
                      ),
                      Text(item.quantity.toString(), style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () async {
                          await PersistentShoppingCart().incrementCartItemQuantity(item.productId);
                          widget.onChange?.call();
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () async {
                          await PersistentShoppingCart().removeFromCart(item.productId);
                          widget.onChange?.call();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: PersistentShoppingCart().showTotalAmountWidget(
          cartTotalAmountWidgetBuilder: (total) {
            return Row(
              children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('${PersistentShoppingCart().getCartItemCount()} item(s)', style: const TextStyle(color: Colors.grey)),
                  ]),
                ),
                ElevatedButton(
                  onPressed: PersistentShoppingCart().getCartItemCount() == 0
                      ? null
                      : () {
                          // dummy checkout
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Checkout'),
                              content: Text('Total: \$${total.toStringAsFixed(2)}'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                                TextButton(
                                  onPressed: () {
                                    PersistentShoppingCart().clearCart();
                                    widget.onChange?.call();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed (demo)')));
                                  },
                                  child: const Text('Place Order'),
                                ),
                              ],
                            ),
                          );
                        },
                  child: const Text('Checkout'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}