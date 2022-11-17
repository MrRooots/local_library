import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/usecases/usecase.dart';
import 'package:local_library/domain/repositories/customer_repository.dart';

class RegisterCustomerParams extends Equatable {
  /// Customer username
  final String username;

  /// Customer password
  final String password;

  /// Customer name
  final String name;

  /// Customer surname
  final String surname;

  /// Customer address
  final String address;

  /// Customer phone
  final String phone;

  const RegisterCustomerParams({
    required this.username,
    required this.password,
    required this.name,
    required this.surname,
    required this.address,
    required this.phone,
  });

  @override
  List<Object?> get props => [username, password];
}

/// Make login request to remote database using user credentials
///
/// Returns [UserEntity] or [Failure]
class RegisterCustomer extends UseCase<void, RegisterCustomerParams> {
  final CustomerRepository repository;

  RegisterCustomer({required this.repository});

  @override
  Future<Either<void, Failure>> call(
    final RegisterCustomerParams params,
  ) async {
    return await repository.registerCustomer(
      username: params.username,
      password: params.password,
      name: params.name,
      surname: params.surname,
      address: params.address,
      phone: params.phone,
    );
  }
}
