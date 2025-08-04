import 'dart:convert';

import 'package:attendence_app/Models/cart_item,_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCart {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart') ?? '[]';
    final List<dynamic> decoded = json.decode(cartData);
    _items = decoded.map((e) => CartItem.fromJson(e)).toList();
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(_items.map((e) => e.toJson()).toList());
    await prefs.setString('cart', encoded);
  }

  void addItem(CartItem item) {
    final index = _items.indexWhere((e) => e.sku == item.sku);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(item);
    }
    saveCart();
  }

  void clearCart() {
    _items.clear();
    saveCart();
  }

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}