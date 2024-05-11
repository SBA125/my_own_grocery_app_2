import 'product.dart';

class Order {
  final String id;
  final List<Product> products;
  final double totalAmount;
  // Add more fields as needed

  Order({
    required this.id,
    required this.products,
    required this.totalAmount,
    // Add more fields as needed
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      products: (json['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      // Add more fields as needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((product) => product.toJson()).toList(),
      'totalAmount': totalAmount,
      // Add more fields as needed
    };
  }
}
