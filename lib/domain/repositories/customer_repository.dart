import 'package:dartz/dartz.dart';

import 'package:local_library/core/failures/failures.dart';

import 'package:local_library/domain/entities/customer_entity.dart';

abstract class CustomerRepository {
  /// Performs user login with [username] and [password]
  ///
  /// Returns [CustomerEntity] on success or [Failure]
  Future<Either<CustomerEntity, Failure>> login({
    required final String username,
    required final String password,
  });

  /// Login user with existing data
  ///
  /// Returns [CustomerEntity] or [Failure]
  Future<Either<CustomerEntity, Failure>> loginWithCache();

  /// Logout customer and delete local cached data
  ///
  /// Returns [void] or [Failure]
  Future<Either<void, Failure>> logoutCustomer();

  /// Register new customer account useng provided data
  ///
  /// Returns [void] or [Failure]
  Future<Either<void, Failure>> registerCustomer({
    required final String username,
    required final String password,
    required final String name,
    required final String surname,
    required final String address,
    required final String phone,
  });
}
