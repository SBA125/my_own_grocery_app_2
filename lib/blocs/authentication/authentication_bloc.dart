import 'package:bloc/bloc.dart';
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
    on<AuthenticationGmailLoginRequested>(_mapGoogleSignInRequestedToState);
  }

  Future<void> _mapSignInRequestedToState(AuthenticationSignInRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final user = await _authenticationRepository.signInWithEmailAndPassword(event.email, event.password);
      if (user != null) {
        final String userID = user.uid;
        final String role = await _userRepository.getUserRole(userID);
        emit(AuthenticationAuthenticated(user, role));
      } else {
        emit(const AuthenticationError('Sign-in failed'));
      }
    } catch (e) {
      emit(AuthenticationError('Sign-in failed: $e'));
    }
  }

  Future<void> _mapGoogleSignInRequestedToState(AuthenticationGmailLoginRequested event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoading());
      final user = await _authenticationRepository.signInWithGoogle();
      if (user != null) {
        final String userID = user.uid;
        final String role = await _userRepository.getUserRole(userID);
        emit(AuthenticationAuthenticated(user, role)); // Emit authenticated state with role
      } else {
        emit(const AuthenticationError('Sign-in failed')); // Emit error state
      }
    } catch (e) {
      emit(AuthenticationError('Sign-in failed: $e')); // Emit error state
    }
  }

  Future<void> _mapSignUpRequestedToState(AuthenticationSignUpRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final user = await _authenticationRepository.signUpWithEmailAndPassword(event.email, event.password, event.username);
      if (user != null) {
        final String userID = user.uid;
        final String role = await _userRepository.getUserRole(userID);
        emit(AuthenticationAuthenticated(user, role)); // Emit authenticated state with role
      } else {
        emit(const AuthenticationError('Sign-up failed')); // Emit error state
      }
    } catch (e) {
      emit(AuthenticationError('Sign-up failed: $e')); // Emit error state
    }
  }

  Future<void> _mapSignOutRequestedToState(AuthenticationSignOutRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await _authenticationRepository.signOut();
      emit(AuthenticationUnauthenticated()); // Emit unauthenticated state
    } catch (e) {
      emit(AuthenticationError('Sign-out failed: $e')); // Emit error state
    }
  }
}
