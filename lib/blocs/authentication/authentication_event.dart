import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Event to request sign-in with email and password
class AuthenticationSignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationSignInRequested(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Implement other authentication events: SignUp, SignOut, etc.
// Event to request sign-up with email and password
class AuthenticationSignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationSignUpRequested(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Event to request sign-out
class AuthenticationSignOutRequested extends AuthenticationEvent {
  const AuthenticationSignOutRequested();

  @override
  List<Object> get props => [];
}
