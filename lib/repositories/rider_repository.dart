import 'package:my_own_grocery_app_2/services/firebase_rider_service.dart';

import '../models/order.dart';

class RiderRepository{
  final FirebaseRiderService firebaseRiderService;

  RiderRepository({required this.firebaseRiderService});

  Future<List<Order>> getAllOrders() async{
    return await firebaseRiderService.getAllOrders();
  }

  Future<Order> getOrder(String orderID) async {
    return await firebaseRiderService.getOrder(orderID);
  }

}