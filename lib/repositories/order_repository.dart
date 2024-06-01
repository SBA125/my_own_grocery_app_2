import 'dart:math';

import 'package:my_own_grocery_app_2/models/order.dart' as userOrder;
import '../models/cart.dart';
import '../models/order.dart';
import '../services/firebase_order_service.dart';


class OrderRepository {
  final OrderService orderService;

  OrderRepository({required this.orderService});

  Future<void> placeOrder(Map<String, dynamic> order) async {
    await orderService.saveOrder(order);
  }

  Future<userOrder.Order> getOrder(String orderID) async {
    return await orderService.fetchOrder(orderID);
  }

  Future<List<userOrder.Order>> getOrderHistory(String userId) async{
    return await orderService.getOrderHistory(userId);
  }

// Other repository methods like updateOrderStatus, getOrderHistory, etc.
}