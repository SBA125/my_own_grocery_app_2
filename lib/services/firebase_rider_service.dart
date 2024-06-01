import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order.dart' as userOrder;

class FirebaseRiderService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<userOrder.Order>> getAllOrders() async {
    final snapshot = await _firestore.collection('Orders').get();
    return snapshot.docs.map((doc) => userOrder.Order.fromMap(doc.data(), doc.id)).toList();
  }

  Future<userOrder.Order> getOrder(String orderId) async {
    final doc = await _firestore.collection("Orders").doc(orderId).get();
    if (doc.exists) {
      return userOrder.Order.fromMap(doc.data()!, doc.id);
    } else {
      throw Exception('Order not found');
    }
  }

}