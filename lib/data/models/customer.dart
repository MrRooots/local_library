import 'package:local_library/core/constants/types.dart';
import 'package:local_library/core/failures/utils.dart';
import 'package:local_library/data/models/request.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/entities/request_entity.dart';

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
    required final RequestEntity request,
  }) : super(
          id: id,
          username: username,
          name: name,
          password: password,
          surname: surname,
          address: address,
          phone: phone,
          status: status,
          request: request,
        );

  /// Build [CustomerModel] from given [json] and optional [request]
  factory CustomerModel.fromJson({
    required final Map<String, dynamic> json,
    final RequestModel? request,
  }) =>
      CustomerModel(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        name: json['name'],
        surname: json['surname'],
        address: json['address'],
        phone: json['phone'],
        status: Utils.parseStatus(json['status']),
        request: request ??
            (json['request'] != null
                ? RequestModel.fromJson(json: json['request'])
                : RequestModel.empty()),
      );

  /// Create empty [CustomerModel] with undefined [CustomerStatus]
  factory CustomerModel.empty() => CustomerModel(
        id: 0,
        username: 'username',
        password: 'password',
        name: 'name',
        surname: 'surname',
        address: 'address',
        phone: 'phone',
        status: CustomerStatus.undefined,
        request: RequestModel.empty(),
      );

  /// Creates a copy of current [CustomerModel] with given values
  CustomerModel copyWith({
    final int? id,
    final String? username,
    final String? password,
    final String? name,
    final String? surname,
    final String? address,
    final String? phone,
    final CustomerStatus? status,
    final RequestEntity? request,
  }) =>
      CustomerModel(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        request: request ?? this.request,
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
        'request': (request as RequestModel).toJson(),
      };

  /// Get [CustomerModel] avatar filename
  String get customerAvatarFilename => '${username.toLowerCase()}.png';
}
