part of 'customer_register_bloc.dart';

abstract class CustomerRegisterEvent extends Equatable {
  const CustomerRegisterEvent();

  @override
  List<Object> get props => [];
}

class CustomerRegisterStart extends CustomerRegisterEvent {
  final String username;
  final String password;
  final String name;
  final String surname;
  final String phone;
  final String address;

  const CustomerRegisterStart({
    required this.username,
    required this.password,
    required this.name,
    required this.surname,
    required this.phone,
    required this.address,
  });

  List<String> get params => [
        username,
        password,
        name,
        surname,
        phone,
        address,
      ];
}

class ClearRegisterFormFields extends CustomerRegisterEvent {
  const ClearRegisterFormFields();
}
