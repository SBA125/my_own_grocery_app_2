class Product {
  final String productID;
  final String name;
  final String description;
  final double price;
  final String categoryID; // Reference to Categories collection
  // Add other product details as needed

  Product({
    required this.productID,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryID,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      productID: data['productID'],
      name: data['name'],
      description: data['description'],
      price: data['price'],
      categoryID: data['categoryID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'name': name,
      'description': description,
      'price': price,
      'categoryID': categoryID,
    };
  }
}
