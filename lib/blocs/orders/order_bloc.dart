import 'package:bloc/bloc.dart';

import '../../repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(const OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
    on<FetchOrderHistory>(_onFetchOrderHistory);
    on<ChangeOrderStatus>(_onChangeOrderStatus);
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    try {
      emit(const OrderLoading());
      await orderRepository.placeOrder(event.order.toMap());
      emit(const OrderPlaced());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
  
  Future<void> _onFetchOrderHistory(
      FetchOrderHistory event, Emitter<OrderState> emit) async{
    emit(const OrderHistoryLoading());
    try{
      final orders = await orderRepository.getOrderHistory(event.userID);
      emit(OrderHistoryLoaded(orders));
    } catch(e){
      emit(OrderHistoryError(e.toString()));
    }
  }

  Future<void> _onChangeOrderStatus(
      ChangeOrderStatus event, Emitter<OrderState> emit) async {
    try {
      emit(const OrderLoading());


      final order = await orderRepository.getOrder(event.orderId);

      // Determine the new isReview status based on the new status
      bool newIsReview;
      if (event.newStatus == 'delivery complete') {
        newIsReview = true;
      } else if (event.newStatus == 'closed') {
        newIsReview = false;
      } else {
        newIsReview = order.isReview;
      }

      final updatedOrder = order.copyWith(status: event.newStatus, isReview: newIsReview);
      await orderRepository.updateOrderStatus(event.orderId, updatedOrder.toMap());
      emit(OrderStatusChanged(updatedOrder));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

}