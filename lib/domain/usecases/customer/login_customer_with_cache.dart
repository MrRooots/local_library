import 'package:dartz/dartz.dart';

import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/usecases/usecase.dart';

import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/repositories/customer_repository.dart';

/// Make login request to remote database using stored user credentials
///
/// Returns [UserEntity] or [Failure]
class LoginCustomerWithCache extends UseCaseWithoutParams<CustomerEntity> {
  final CustomerRepository repository;

  LoginCustomerWithCache({required this.repository});

  @override
  Future<Either<CustomerEntity, Failure>> call() async {
    return await repository.loginWithCache();
  }
}
