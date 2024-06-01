import 'package:bloc/bloc.dart';
import 'package:my_own_grocery_app_2/blocs/rider/rider_event.dart';
import 'package:my_own_grocery_app_2/blocs/rider/rider_state.dart';

import '../../repositories/rider_repository.dart';

class RiderBloc extends Bloc<RiderEvent, RiderState> {
  final RiderRepository riderRepository;
  RiderBloc({required this.riderRepository}) : super(RiderInitial()) {
    on<SetRiderAvailable>(_onSetRiderAvailable);
    on<SetRiderUnavailable>(_onSetRiderUnavailable);
    on<RiderLoadAllOrders>(_loadAllOrders);
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

}
