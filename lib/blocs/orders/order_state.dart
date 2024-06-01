import 'package:equatable/equatable.dart';

import '../../models/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderPlaced extends OrderState {
  const OrderPlaced();
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object> get props => [message];
}

class OrderHistoryLoading extends OrderState {
  const OrderHistoryLoading();
}

class OrderHistoryLoaded extends OrderState {
  final List<Order> orders;

  const OrderHistoryLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderHistoryError extends OrderState {
  final String message;

  const OrderHistoryError(this.message);

  @override
  List<Object> get props => [message];
}
