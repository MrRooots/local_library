import 'package:equatable/equatable.dart';
import 'package:local_library/core/constants/types.dart';

class CustomerEntity extends Equatable {
  /// Customer database id
  final int id;

  /// Customer username
  final String username;

  /// Customer md5 hashed password
  final String password;

  /// Customer name
  final String name;

  /// Customer surname
  final String surname;

  /// Customer address
  final String address;

  /// Customer phone number
  final String phone;

  /// Customer login status
  final CustomerStatus status;

  /// Constructor
  const CustomerEntity({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.surname,
    required this.address,
    required this.phone,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        name,
        surname,
        address,
        phone,
        status,
      ];
}
