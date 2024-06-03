import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order.dart' as userOrder;
class OrderService {


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveOrder(Map<String, dynamic> order) async {
    await _firestore.collection("Orders").add(order);
  }

  Future<userOrder.Order> fetchOrder(String orderId) async {
    final doc = await _firestore.collection("Orders").doc(orderId).get();
    if (doc.exists) {
      return userOrder.Order.fromMap(doc.data()!, doc.id);
    } else {
      throw Exception('Order not found');
    }
  }

  String generateOrderId() {
    return _firestore.collection("Orders").doc().id;
  }

  Future<List<userOrder.Order>> getOrderHistory(String userId) async{
    try {
      final querySnapshot = await _firestore
          .collection("Orders")
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data();
          return userOrder.Order.fromMap(data, doc.id);
        }).toList();
      } else {
        throw Exception('No order history');
      }
    } catch (e) {
      throw Exception('Failed to fetch order history: $e');
    }
  }

  Future<void> updateOrderStatus(String orderID, Map<String, dynamic> updatedOrder) async {
    await _firestore.collection("Orders").doc(orderID).update(updatedOrder);
  }

}

