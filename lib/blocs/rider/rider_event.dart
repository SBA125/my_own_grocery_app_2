import 'package:equatable/equatable.dart';

import '../../models/order.dart';

abstract class RiderEvent extends Equatable {
  const RiderEvent();

  @override
  List<Object> get props => [];
}

class SetRiderAvailable extends RiderEvent {}

class SetRiderUnavailable extends RiderEvent {}

class RiderLoadAllOrders extends RiderEvent {}

class AcceptOrder extends RiderEvent {
  final Order order;

  const AcceptOrder(this.order);

  @override
  List<Object> get props => [order];
}

class CompleteOrder extends RiderEvent {
  final Order order;

  const CompleteOrder(this.order);

  @override
  List<Object> get props => [order];
}



