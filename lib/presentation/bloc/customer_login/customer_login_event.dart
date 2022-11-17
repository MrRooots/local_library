part of 'customer_login_bloc.dart';

abstract class CustomerLoginEvent extends Equatable {
  const CustomerLoginEvent();

  @override
  List<Object> get props => [];
}

/// Start customer login with [username] and [password]
class CustomerLoginStart extends CustomerLoginEvent {
  final String username;
  final String password;

  const CustomerLoginStart({required this.username, required this.password});
}

/// Restoring customer credentials from cached data
class RestoreCustomerSession extends CustomerLoginEvent {
  const RestoreCustomerSession();
}

/// Clear all login form fields and error boxes
class ClearLoginFormFields extends CustomerLoginEvent {
  const ClearLoginFormFields();
}
