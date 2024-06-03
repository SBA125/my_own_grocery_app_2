import 'package:bloc/bloc.dart';
import 'package:my_own_grocery_app_2/blocs/rider/rider_event.dart';
import 'package:my_own_grocery_app_2/blocs/rider/rider_state.dart';

import '../../repositories/order_repository.dart';
import '../../repositories/rider_repository.dart';

class RiderBloc extends Bloc<RiderEvent, RiderState> {
  final RiderRepository riderRepository;
  final OrderRepository orderRepository;
  RiderBloc({required this.riderRepository, required this.orderRepository}) : super(RiderInitial()) {
    on<SetRiderAvailable>(_onSetRiderAvailable);
    on<SetRiderUnavailable>(_onSetRiderUnavailable);
    on<RiderLoadAllOrders>(_loadAllOrders);
    on<AcceptOrder>(_onAcceptOrder);
    on<CompleteOrder>(_onCompleteOrder);
  }

  Future<void> _onSetRiderAvailable(SetRiderAvailable event, Emitter<RiderState> emit) async {
    try {
      emit(RiderAvailable());
    } catch (e) {
      emit(RiderError(e.toString()));
    }
  }

  Future<void> _onSetRiderUnavailable(SetRiderUnavailable event, Emitter<RiderState> emit) async {
    try {
      emit(RiderUnavailable());
    } catch (e) {
      emit(RiderError(e.toString()));
    }
  }

  Future<void> _loadAllOrders(RiderLoadAllOrders event, Emitter<RiderState> emit) async {
    emit(RiderOrderLoading());
    try {
      final orders = await riderRepository.getAllOrders();
      emit(RiderLoadedOrders(orders));
    } catch (e) {
      emit(RiderError(e.toString()));
    }
  }

  Future<void> _onAcceptOrder(AcceptOrder event, Emitter<RiderState> emit) async {
    try {
      emit(RiderUnavailable());
      final updatedOrder = event.order.copyWith(status: 'in-progress');
      await orderRepository.updateOrderStatus(updatedOrder.id, updatedOrder.toMap());
      emit(OrderAccepted(updatedOrder));
    } catch (e) {
      emit(RiderError(e.toString()));
    }
  }

  Future<void> _onCompleteOrder(CompleteOrder event, Emitter<RiderState> emit) async {
    try {
      final updatedOrder = event.order.copyWith(status: 'delivery complete', isReview: true);
      await orderRepository.updateOrderStatus(updatedOrder.id, updatedOrder.toMap());
      emit(OrderCompleted(updatedOrder));
    } catch (e) {
      emit(RiderError(e.toString()));
    }
  }

}
