part of 'customer_login_bloc.dart';

abstract class CustomerLoginState extends Equatable {
  const CustomerLoginState();

  @override
  List<Object> get props => [];
}

/// Initial state user login status is undefined
class CustomerLoginUndefined extends CustomerLoginState {
  const CustomerLoginUndefined();
}

/// User login in process
class CustomerLoginLoading extends CustomerLoginState {}

/// User login successful
class CustomerLoginSuccessful extends CustomerLoginState {
  final CustomerEntity customer;

  const CustomerLoginSuccessful({required this.customer});

  @override
  List<Object> get props => [customer];
}

/// User login failed
class CustomerLoginFailed extends CustomerLoginState {
  final String errorMessage;

  const CustomerLoginFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
