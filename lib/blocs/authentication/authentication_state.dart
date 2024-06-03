import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}


class AuthenticationInitial extends AuthenticationState {}


class AuthenticationAuthenticated extends AuthenticationState {
  final User user;
  final String role;
  const AuthenticationAuthenticated(this.user, this.role);

  @override
  List<Object> get props => [user, role];
}


class AuthenticationUnauthenticated extends AuthenticationState {}


class AuthenticationLoading extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
