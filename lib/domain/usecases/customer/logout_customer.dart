import 'package:dartz/dartz.dart';

import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/usecases/usecase.dart';
import 'package:local_library/domain/repositories/customer_repository.dart';

/// Make login request to remote database using user credentials
///
/// Returns [UserEntity] or [Failure]
class LogoutCustomer extends UseCaseWithoutParams<void> {
  final CustomerRepository repository;

  LogoutCustomer({required this.repository});

  @override
  Future<Either<void, Failure>> call() async {
    return await repository.logoutCustomer();
  }
}
