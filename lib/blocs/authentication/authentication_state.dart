import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

// Initial state
class AuthenticationInitial extends AuthenticationState {

}

// State indicating that the user is authenticated
class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  const AuthenticationAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

// State indicating that the user is not authenticated
class AuthenticationUnauthenticated extends AuthenticationState {}

// State indicating that authentication is in progress
class AuthenticationLoading extends AuthenticationState {}

// State indicating that an error occurred during authentication
class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
