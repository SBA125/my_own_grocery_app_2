import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productID;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final int quantity;
  final bool inStock;

  Product({
    required this.productID,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.inStock,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      productID: data['productID'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0, // Handle null by providing a default value
      imageUrl: data['imageUrl'] ?? '',
      quantity: data['quantity'] ?? 0, // Handle null by providing a default value
      inStock: data['inStock'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'inStock': inStock,
    };
  }

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Product(
      productID: snapshot.id,
      name: data['name'],
      description: data['description'],
      price: data['price'],
      imageUrl: data['imageUrl'],
      quantity: data['quantity'],
      inStock: data['inStock'],
    );
  }

  Product copyWith({
    required String productID,
    required String name,
    required String description,
    required int price,
    required String imageUrl,
    required int quantity,
    required bool inStock,
  }) {
    return Product(
      productID: productID,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity,
      inStock: inStock,
    );
  }


}
