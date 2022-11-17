part of 'customer_register_bloc.dart';

abstract class CustomerRegisterState extends Equatable {
  const CustomerRegisterState();

  @override
  List<Object> get props => [];
}

/// Initial state user Register status is undefined
class CustomerRegisterUndefined extends CustomerRegisterState {
  const CustomerRegisterUndefined();
}

/// User Register in process
class CustomerRegisterLoading extends CustomerRegisterState {
  const CustomerRegisterLoading();
}

/// User Register successful
class CustomerRegisterSuccessful extends CustomerRegisterState {
  const CustomerRegisterSuccessful();
}

/// User Register failed
class CustomerRegisterFailed extends CustomerRegisterState {
  final String errorMessage;

  const CustomerRegisterFailed({required this.errorMessage});
}
