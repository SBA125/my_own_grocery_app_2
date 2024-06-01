import 'package:equatable/equatable.dart';

abstract class RiderEvent extends Equatable {
  const RiderEvent();

  @override
  List<Object> get props => [];
}

class SetRiderAvailable extends RiderEvent {}

class SetRiderUnavailable extends RiderEvent {}

class RiderLoadAllOrders extends RiderEvent {}
