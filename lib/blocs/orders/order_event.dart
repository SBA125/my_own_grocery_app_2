import 'package:equatable/equatable.dart';
import '../../models/order.dart';

abstract class OrderEvent {
  const OrderEvent();

  List<Object> get props => [];
}

class PlaceOrder extends OrderEvent {
  final Order order;

  PlaceOrder(this.order);
}

class FetchOrderHistory extends OrderEvent {
  final String userID;

  const FetchOrderHistory(this.userID);

  @override
  List<Object> get props => [userID];
}
