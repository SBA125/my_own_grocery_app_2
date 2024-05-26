import 'package:bloc/bloc.dart';
import 'package:my_own_grocery_app_2/blocs/users/user_event.dart';
import 'package:my_own_grocery_app_2/blocs/users/user_state.dart';

import '../../models/user.dart';
import '../../repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserLoading()) {
    on<FetchUserDetails>(_onFetchUserDetails);
  }

  void _onFetchUserDetails(FetchUserDetails event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.displayUserDetails();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Failed to fetch user details: $e'));
    }
  }
}