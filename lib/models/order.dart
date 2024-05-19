class Order {
  final String orderID;
  final String userID;
  final List<Map<String, dynamic>> products; // List of product IDs and quantities
  final double totalPrice;
  final String orderStatus;
  final String paymentMethod;
  // Add other order details as needed

  Order({
    required this.orderID,
    required this.userID,
    required this.products,
    required this.totalPrice,
    required this.orderStatus,
    required this.paymentMethod,
  });

  factory Order.fromMap(Map<String, dynamic> data) {
    return Order(
      orderID: data['orderID'],
      userID: data['userID'],
      products: List<Map<String, dynamic>>.from(data['products']),
      totalPrice: data['totalPrice'],
      orderStatus: data['orderStatus'],
      paymentMethod: data['paymentMethod'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID,
      'userID': userID,
      'products': products,
      'totalPrice': totalPrice,
      'orderStatus': orderStatus,
      'paymentMethod': paymentMethod,
    };
  }
}
