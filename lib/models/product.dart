// models/product.dart
import 'category.dart'; // Import the Category class if not already imported

class Product {
  final String id;
  final String name;
  final double price;
  final Category category;
  final String imageUrl; // Add an image property

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl, // Include imageUrl in the constructor
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: Category.fromJson(json['category']),
      imageUrl: json['imageUrl'] as String, // Parse imageUrl from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category.toJson(),
      'imageUrl': imageUrl, // Include imageUrl in the JSON representation
    };
  }
}
