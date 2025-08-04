import 'package:attendence_app/Models/cart_item,_model.dart';
import 'package:attendence_app/Models/product_model.dart';
import 'package:attendence_app/Services/shopping_cart.dart';
import 'package:flutter/material.dart';

class PunchOrderView extends StatefulWidget {
  const PunchOrderView({super.key});

  @override
  State<PunchOrderView> createState() => _PunchOrderViewState();
}

class _PunchOrderViewState extends State<PunchOrderView> {
  final ShoppingCart _cart = ShoppingCart();

  final List<Product> _products = [
    Product(
      title: 'Mezan Hardum',
      sku: 'SKU001',
      imageUrl: 'assets/product1.jfif',
      price: 29.99,
    ),
    Product(
      title: 'Mezan Ultra Rich',
      sku: 'SKU002',
      imageUrl: 'assets/product2.jfif',
      price: 49.99,
    ),
    Product(
      title: 'Mezan Danedar',
      sku: 'SKU003',
      imageUrl: 'assets/product3.jfif',
      price: 19.99,
    ),
    Product(
      title: 'Hardum Mixture',
      sku: 'SKU004',
      imageUrl: 'assets/product4.jfif',
      price: 39.99,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cart.loadCart().then((_) => setState(() {}));
  }

  void _showCartDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cart'),
        content: SizedBox(
          width: double.maxFinite,
          child: _cart.items.isEmpty
              ? const Text('Your cart is empty.')
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _cart.items
                      .map(
                        (item) => ListTile(
                          title: Text(item.title),
                          subtitle: Text('Qty: ${item.quantity}'),
                          trailing: Text(
                            '${(item.price * item.quantity).toStringAsFixed(2)}',
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        actions: [
          Text('Total: \$${_cart.totalPrice.toStringAsFixed(2)}'),
          TextButton(
            onPressed: () {
              setState(() {
                _cart.clearCart();
              });
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text('Punch Order'),

        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_checkout),
            onPressed: _showCartDialog,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        itemCount: _products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.54,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (_, index) {
          final product = _products[index];
          return SizedBox(
            height: 170,
            child: ProductCard(
              product: product,
              cart: _cart,
              onUpdate: () => setState(() {}),
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final ShoppingCart cart;
  final VoidCallback onUpdate;

  const ProductCard({
    super.key,
    required this.product,
    required this.cart,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Image.asset(
                product.imageUrl,
                height: 165,
                width: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'SKU: ${product.sku}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cart.addItem(
                          CartItem(
                            sku: product.sku,
                            title: product.title,
                            price: product.price,
                          ),
                        );
                        onUpdate();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart'),
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_cart),
                    ),

                    const SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
