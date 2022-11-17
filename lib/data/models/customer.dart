import 'package:local_library/core/constants/types.dart';
import 'package:local_library/domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  /// Constructor
  const CustomerModel({
    required final int id,
    required final String username,
    required final String password,
    required final String name,
    required final String surname,
    required final String address,
    required final String phone,
    required final CustomerStatus status,
  }) : super(
          id: id,
          username: username,
          name: name,
          password: password,
          surname: surname,
          address: address,
          phone: phone,
          status: status,
        );

  /// Build [CustomerModel] from given [json]
  factory CustomerModel.fromJson({
    required final Map<String, dynamic> json,
  }) =>
      CustomerModel(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        name: json['name'],
        surname: json['surname'],
        address: json['address'],
        phone: json['phone'],
        status: CustomerStatus.user,
      );

  /// Create empty [CustomerModel] with undefined [CustomerStatus]
  factory CustomerModel.empty() => const CustomerModel(
        id: 0,
        username: 'username',
        password: 'password',
        name: 'name',
        surname: 'surname',
        address: 'address',
        phone: 'phone',
        status: CustomerStatus.undefined,
      );

  /// Convert [CustomerModel] to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'name': name,
        'surname': surname,
        'address': address,
        'phone': phone,
        'status': status.toString().split('.').last,
      };

  /// Get [CustomerModel] avatar filename
  String get customerAvatarFilename => '${username.toLowerCase()}.png';
}
