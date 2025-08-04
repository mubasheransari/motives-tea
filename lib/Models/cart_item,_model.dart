class CartItem {
  final String sku;
  final String title;
  final double price;
  int quantity;

  CartItem({
    required this.sku,
    required this.title,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'sku': sku,
        'title': title,
        'price': price,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        sku: json['sku'],
        title: json['title'],
        price: json['price'],
        quantity: json['quantity'],
      );
}
