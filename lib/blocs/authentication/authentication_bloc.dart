import 'package:bloc/bloc.dart';
import 'package:my_own_grocery_app_2/models/user.dart';
import '../../repositories/authentication_repository.dart';
import '../../repositories/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  AuthenticationBloc(this._authenticationRepository, this._userRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationSignInRequested>(_mapSignInRequestedToState);
    on<AuthenticationSignUpRequested>(_mapSignUpRequestedToState);
    on<AuthenticationSignOutRequested>(_mapSignOutRequestedToState);
  }

  Future<void> _mapSignInRequestedToState(
      AuthenticationSignInRequested event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final user = await _authenticationRepository.signInWithEmailAndPassword(
          event.email, event.password);
      if (user != null) {
        emit(AuthenticationAuthenticated(user)); // Emit authenticated state
      } else {
        emit(const AuthenticationError('Sign-in failed')); // Emit error state
      }
    } catch (e) {
      emit(AuthenticationError('Sign-in failed: $e')); // Emit error state
    }
  }

  Future<void> _mapSignUpRequestedToState(
      AuthenticationSignUpRequested event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final user = await _authenticationRepository.signUpWithEmailAndPassword(
        event.email,
        event.password,
        event.username,
      );
      emit(AuthenticationAuthenticated(user!));
    } catch (e) {
      emit(AuthenticationError('Sign-up failed: $e')); // Emit error state
      print('Sign-up failed: $e');
    }
  }


  Future<void> _mapSignOutRequestedToState(
      AuthenticationSignOutRequested event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await _authenticationRepository.signOut();
      emit(AuthenticationUnauthenticated()); // Emit unauthenticated state
    } catch (e) {
      emit(AuthenticationError('Sign-out failed: $e')); // Emit error state
    }
  }
}
