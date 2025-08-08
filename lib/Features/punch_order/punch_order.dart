import 'package:attendence_app/Features/punch_order/cart_screen.dart';
import 'package:attendence_app/Models/product_model.dart';

import 'package:flutter/material.dart';


import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class PunchOrderView extends StatefulWidget {
  const PunchOrderView({super.key});
  @override
  State<PunchOrderView> createState() => _PunchOrderViewState();
}

class _PunchOrderViewState extends State<PunchOrderView> {
  final List<Product> _products = [
    Product(title: 'Mezan Hardum', sku: 'SKU001', imageUrl: 'assets/product1.jfif', price: 29.99),
    Product(title: 'Mezan Ultra Rich', sku: 'SKU002', imageUrl: 'assets/product2.jfif', price: 49.99),
    Product(title: 'Mezan Danedar', sku: 'SKU003', imageUrl: 'assets/product3.jfif', price: 19.99),
    Product(title: 'Hardum Mixture', sku: 'SKU004', imageUrl: 'assets/product4.jfif', price: 39.99),
    Product(title: 'Hardum Mix 5', sku: 'SKU005', imageUrl: 'assets/product5.jfif', price: 39.99),
    Product(title: 'Hardum Mix 6', sku: 'SKU006', imageUrl: 'assets/product6.jfif', price: 39.99),
  ];

  // map sku -> quantity (keeps UI in sync)
  final Map<String, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    _reloadQuantities(); // load saved quantities after init
  }

  void _reloadQuantities() {
    // getCartData() returns: {'cartItems': List<PersistentShoppingCartItem>, 'totalPrice': double}
    final cartData = PersistentShoppingCart().getCartData();
    final items = cartData['cartItems'] as List<dynamic>? ?? <dynamic>[];
    _quantities.clear();
    for (final it in items) {
      if (it is PersistentShoppingCartItem) {
        _quantities[it.productId] = it.quantity;
      }
    }
    setState(() {}); // refresh UI
  }

  int _qtyFor(String sku) => _quantities[sku] ?? 0;

  Future<void> _increment(Product p) async {
    final cur = _qtyFor(p.sku);
    if (cur == 0) {
      // add product with quantity 1
      await PersistentShoppingCart().addToCart(
        PersistentShoppingCartItem(
          productId: p.sku,
          productName: p.title,
          productThumbnail: p.imageUrl,
          unitPrice: p.price,
          quantity: 1,
        ),
      );
    } else {
      // increment existing product's quantity by 1
      await PersistentShoppingCart().incrementCartItemQuantity(p.sku);
    }
    _reloadQuantities();
  }

  Future<void> _decrement(Product p) async {
    final cur = _qtyFor(p.sku);
    if (cur <= 1) {
      // remove completely
      await PersistentShoppingCart().removeFromCart(p.sku);
    } else {
      // reduce quantity by 1
      await PersistentShoppingCart().decrementCartItemQuantity(p.sku);
    }
    _reloadQuantities();
  }

  void _openCartScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CartScreen(onChange: _reloadQuantities),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Punch Order'),
        actions: [
          // Cart button (navigates to cart)
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: _openCartScreen,
          ),

          // Live item count widget from the package (updates automatically)
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 12),
            child: PersistentShoppingCart().showCartItemCountWidget(
              cartItemCountWidgetBuilder: (count) {
                if (count <= 0) return const SizedBox.shrink();
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                  child: Text(count.toString(), style: const TextStyle(color: Colors.white, fontSize: 12)),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Center(child: Text("Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400))),
            GridView.builder(
              physics: const BouncingScrollPhysics(),
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
                final qty = _qtyFor(product.sku);
                return SizedBox(
                  height: 170,
                  child: ProductCard(
                    product: product,
                    quantity: qty,
                    onIncrement: () => _increment(product),
                    onDecrement: () => _decrement(product),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(product.imageUrl, height: 165, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('SKU: ${product.sku}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Text('Price: \$${product.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.blue, fontSize: 12)),
              const SizedBox(height: 9),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                InkWell(
                  onTap: onIncrement,
                  child: const CircleAvatar(radius: 14, backgroundColor: Colors.blue, child: Icon(Icons.add, color: Colors.white, size: 18)),
                ),
                Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
                InkWell(
                  onTap: onDecrement,
                  child: const CircleAvatar(radius: 14, backgroundColor: Colors.blue, child: Icon(Icons.remove, color: Colors.white, size: 18)),
                ),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}

// class PunchOrderView extends StatefulWidget {
//   const PunchOrderView({super.key});

//   @override
//   State<PunchOrderView> createState() => _PunchOrderViewState();
// }

// class _PunchOrderViewState extends State<PunchOrderView> {
//   final ShoppingCart _cart = ShoppingCart();
// //i have this code and i want to apply this plugin along with the cart screen i dont have card screen right now
//   final List<Product> _products = [
//     Product(
//       title: 'Mezan Hardum',
//       sku: 'SKU001',
//       imageUrl: 'assets/product1.jfif',
//       price: 29.99,
//     ),
//     Product(
//       title: 'Mezan Ultra Rich',
//       sku: 'SKU002',
//       imageUrl: 'assets/product2.jfif',
//       price: 49.99,
//     ),
//     Product(
//       title: 'Mezan Danedar',
//       sku: 'SKU003',
//       imageUrl: 'assets/product3.jfif',
//       price: 19.99,
//     ),
//     Product(
//       title: 'Hardum Mixture',
//       sku: 'SKU004',
//       imageUrl: 'assets/product4.jfif',
//       price: 39.99,
//     ),
//     Product(
//       title: 'Hardum Mixture',
//       sku: 'SKU004',
//       imageUrl: 'assets/product5.jfif',
//       price: 39.99,
//     ),
//     Product(
//       title: 'Hardum Mixture',
//       sku: 'SKU004',
//       imageUrl: 'assets/product6.jfif',
//       price: 39.99,
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _cart.loadCart().then((_) => setState(() {}));
//   }

//   void _showCartDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Cart'),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: _cart.items.isEmpty
//               ? const Text('Your cart is empty.')
//               : Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: _cart.items
//                       .map(
//                         (item) => ListTile(
//                           title: Text(item.title),
//                           subtitle: Text('Qty: ${item.quantity}'),
//                           trailing: Text(
//                             '${(item.price * item.quantity).toStringAsFixed(2)}',
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//         ),
//         actions: [
//           Text('Total: \$${_cart.totalPrice.toStringAsFixed(2)}'),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 _cart.clearCart();
//               });
//               Navigator.pop(context);
//             },
//             child: const Text('Clear'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.white,
//       //   automaticallyImplyLeading: false,
//       //   title: const Text('Punch Order'),

//       //   actions: [
//       //     IconButton(
//       //       icon: Icon(Icons.shopping_cart_checkout),
//       //       onPressed: _showCartDialog,
//       //     ),
//       //   ],
//       // ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
            
//             child: Column(
//               children: [
//                 SizedBox(height: 50),
//                 Center(
//                   child: Text(
//                     "Products",
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 GridView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.all(16),
//                   itemCount: _products.length,
//                   gridDelegate:
//                       const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         childAspectRatio: 0.54,
//                         crossAxisSpacing: 16,
//                         mainAxisSpacing: 16,
//                       ),
//                   itemBuilder: (_, index) {
//                     final product = _products[index];
//                     return SizedBox(
//                       height: 170,
//                       child: ProductCard(
//                         product: product,
//                         cart: _cart,
//                         onUpdate: () => setState(() {}),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final Product product;
//   final ShoppingCart cart;
//   final VoidCallback onUpdate;

//   const ProductCard({
//     super.key,
//     required this.product,
//     required this.cart,
//     required this.onUpdate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(height: 5),
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 2.0),
//               child: Image.asset(
//                 fit: BoxFit.cover,
//                 product.imageUrl,
//                 height: 165,
//                 width: 100,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.title,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'SKU: ${product.sku}',
//                   style: const TextStyle(color: Colors.grey, fontSize: 12),
//                 ),
//                 Text(
//                   'Price: ${product.price}',
//                   style: const TextStyle(color: Colors.blue, fontSize: 12),
//                 ),
//                 const SizedBox(height: 9),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: const CircleAvatar(
//                         radius: 11,
//                         backgroundColor: Colors.blue,
//                         child: Icon(Icons.add, color: Colors.white, size: 20),
//                       ),
//                     ),
//                     Text("0"),
//                     InkWell(
//                       onTap: () {},
//                       child: const CircleAvatar(
//                         radius: 11,
//                         backgroundColor: Colors.blue,
//                         child: Icon(
//                           Icons.remove,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 /*  Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       '${product.price.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         color: Colors.blueAccent,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         cart.addItem(
//                           CartItem(
//                             sku: product.sku,
//                             title: product.title,
//                             price: product.price,
//                           ),
//                         );
//                         onUpdate();
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('${product.title} added to cart'),
//                           ),
//                         );
//                       },
//                       icon: Icon(Icons.shopping_cart),
//                     ),

//                     const SizedBox(height: 4),
//                   ],
//                 ),*/
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
