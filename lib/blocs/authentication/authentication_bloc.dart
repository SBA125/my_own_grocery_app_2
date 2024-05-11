import 'package:bloc/bloc.dart';
import '../../repositories/authentication_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationSignInRequested>(_mapSignInRequestedToState);
    on<AuthenticationSignUpRequested>(_mapSignUpRequestedToState);
    on<AuthenticationSignOutRequested>(_mapSignOutRequestedToState);
  }

  Stream<AuthenticationState> _mapSignInRequestedToState(
      AuthenticationSignInRequested event,
      Emitter<AuthenticationState> emit) async* {
    yield AuthenticationLoading();
    try {
      final user = await _authenticationRepository.signInWithEmailAndPassword(
          event.email, event.password);
      if (user != null) {
        yield AuthenticationAuthenticated(user); // Emit authenticated state
      } else {
        yield const AuthenticationError('Sign-in failed'); // Emit error state
      }
    } catch (e) {
      yield AuthenticationError('Sign-in failed: $e'); // Emit error state
    }
  }

  Stream<AuthenticationState> _mapSignUpRequestedToState(
      AuthenticationSignUpRequested event,
      Emitter<AuthenticationState> emit) async* {
    yield AuthenticationLoading();
    try {
      final user = await _authenticationRepository.signUpWithEmailAndPassword(
          event.email, event.password);
      if (user != null) {
        yield AuthenticationAuthenticated(user); // Emit authenticated state
      } else {
        yield const AuthenticationError('Sign-up failed'); // Emit error state
      }
    } catch (e) {
      yield AuthenticationError('Sign-up failed: $e'); // Emit error state
    }
  }

  Stream<AuthenticationState> _mapSignOutRequestedToState(
      AuthenticationSignOutRequested event,
      Emitter<AuthenticationState> emit) async* {
    yield AuthenticationLoading();
    try {
      await _authenticationRepository.signOut();
      yield AuthenticationUnauthenticated(); // Emit unauthenticated state
    } catch (e) {
      yield AuthenticationError('Sign-out failed: $e'); // Emit error state
    }
  }
}
