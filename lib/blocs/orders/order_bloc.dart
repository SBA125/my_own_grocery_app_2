import 'package:bloc/bloc.dart';

import '../../repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(const OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
    on<FetchOrderHistory>(_onFetchOrderHistory);
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

}