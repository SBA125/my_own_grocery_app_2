class CartItem {
  final String id;
  final String productId;
  final String name;
  final int price;
  final int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory CartItem.fromMap(Map<String, dynamic> data) {
    return CartItem(
      id: data['id'],
      productId: data['productId'],
      name: data['name'],
      price: data['price'],
      quantity: data['quantity'],
      imageUrl: data['imageUrl'],
    );
  }

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    int? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
}
