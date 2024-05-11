// models/category.dart
import 'product.dart'; // Import the Product class

class Category {
  final String name;
  final List<Product> products; // List of products

  Category({
    required this.name,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    // Parse products from JSON
    List<Product> products = (json['products'] as List<dynamic>)
        .map((productJson) => Product.fromJson(productJson))
        .toList();

    return Category(
      name: json['name'] as String,
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    // Convert products to JSON
    List<Map<String, dynamic>> productsJson =
        products.map((product) => product.toJson()).toList();

    return {
      'name': name,
      'products': productsJson,
    };
  }
}
