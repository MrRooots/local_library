part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationEvent {
  const AuthenticationLoading();
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final CustomerEntity customer;

  const AuthenticationLoggedIn({required this.customer});
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  const AuthenticationLoggedOut();
}
