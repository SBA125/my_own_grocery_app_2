import 'package:equatable/equatable.dart';

import '../../models/order.dart';

abstract class RiderState extends Equatable {
  const RiderState();

  @override
  List<Object> get props => [];
}

class RiderInitial extends RiderState {}

class RiderOrderLoading extends RiderState{}

class RiderLoadedOrders extends RiderState {
  final List<Order> orders;

  const RiderLoadedOrders(this.orders);

  @override
  List<Object> get props => [orders];
}

class RiderAvailable extends RiderState {}

class RiderUnavailable extends RiderState {}

class RiderError extends RiderState {
  final String message;

  const RiderError(this.message);

  @override
  List<Object> get props => [message];
}

