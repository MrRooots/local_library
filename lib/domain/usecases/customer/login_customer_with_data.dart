import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/usecases/usecase.dart';

import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/repositories/customer_repository.dart';

class CustomerLoginDataParams extends Equatable {
  final String username, password;

  const CustomerLoginDataParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

/// Make login request to remote database using user credentials
///
/// Returns [UserEntity] or [Failure]
class LoginCustomerWithData
    extends UseCase<CustomerEntity, CustomerLoginDataParams> {
  final CustomerRepository repository;

  LoginCustomerWithData({required this.repository});

  @override
  Future<Either<CustomerEntity, Failure>> call(
    final CustomerLoginDataParams params,
  ) async {
    return await repository.login(
      username: params.username,
      password: params.password,
    );
  }
}
