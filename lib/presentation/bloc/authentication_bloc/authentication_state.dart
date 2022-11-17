part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationAuth extends AuthenticationState {
  final CustomerEntity customer;

  const AuthenticationAuth({required this.customer});
}

class AuthenticationUnauth extends AuthenticationState {
  const AuthenticationUnauth();
}

class AuthenticationUnknown extends AuthenticationState {
  const AuthenticationUnknown();
}
