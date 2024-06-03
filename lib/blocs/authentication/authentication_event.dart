import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStart extends AuthenticationEvent {}

class AuthenticationSignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationSignInRequested(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}


class AuthenticationSignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;

  const AuthenticationSignUpRequested(
      {required this.email, required this.password, required this.username});

  @override
  List<Object> get props => [email, password];
}

class AuthenticationGmailLoginRequested extends AuthenticationEvent {}


class AuthenticationSignOutRequested extends AuthenticationEvent {
  const AuthenticationSignOutRequested();

  @override
  List<Object> get props => [];
}
