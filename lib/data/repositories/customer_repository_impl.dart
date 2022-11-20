import 'package:dartz/dartz.dart';

import 'package:local_library/core/failures/exceptions.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/failures/utils.dart';

import 'package:local_library/data/data_sources/local/customer_local_data_source.dart';
import 'package:local_library/data/data_sources/remote/customer_remote_data_source.dart';
import 'package:local_library/data/data_sources/remote/request_remote_data_source.dart';
import 'package:local_library/data/models/customer.dart';
import 'package:local_library/data/models/request.dart';

import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/repositories/customer_repository.dart';
import 'package:local_library/services/network_info.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource customerRemoteDS;
  final CustomerLocalDataSource customerLocalDS;

  final RequestRemoteDataSource requestRemoteDS;

  final NetworkInfo networkInfo;

  const CustomerRepositoryImpl({
    required this.networkInfo,
    required this.customerRemoteDS,
    required this.customerLocalDS,
    required this.requestRemoteDS,
  });

  @override
  Future<Either<CustomerEntity, Failure>> login({
    required final String username,
    required final String password,
  }) async {
    try {
      final CustomerModel customer = await _getCustomerWithRequest(
        username: username,
        password: password,
      );

      await customerLocalDS.saveCustomerToCache(customer: customer);

      return left(customer);
    } on ServerException catch (error) {
      return right(ServerFailure(errorMessage: error.error));
    } on ConnectionException catch (_) {
      return right(ConnectionFailure());
    } on LoginException catch (error) {
      return right(LoginFailure(errorMessage: error.error));
    } on CacheException catch (error) {
      return right(CacheFailure(errorMessage: error.error));
    } catch (error) {
      return right(UndefinedFailure(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<CustomerEntity, Failure>> loginWithCache() async {
    try {
      final CustomerModel cachedData = await customerLocalDS.getCachedCustomer;

      final CustomerModel customer = await _getCustomerWithRequest(
        username: cachedData.username,
        password: cachedData.password,
        encodePassword: false,
      );

      return left(customer);
    } on ServerException catch (error) {
      return right(ServerFailure(errorMessage: error.toString()));
    } on ConnectionException catch (_) {
      return right(ConnectionFailure());
    } on LoginException catch (error) {
      return right(LoginFailure(errorMessage: error.toString()));
    } on CacheException catch (error) {
      return right(CacheFailure(errorMessage: error.toString()));
    } catch (error) {
      return right(UndefinedFailure(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<void, Failure>> logoutCustomer() async {
    try {
      await customerLocalDS.clearCache();

      return left(null);
    } on CacheException catch (error) {
      return right(CacheFailure(errorMessage: error.toString()));
    } catch (error) {
      return right(UndefinedFailure(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<void, Failure>> registerCustomer({
    required String username,
    required String password,
    required String name,
    required String surname,
    required String address,
    required String phone,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        print('Register start');
        await customerRemoteDS.registerCustomer(
          username: username,
          password: password,
          name: name,
          surname: surname,
          address: address,
          phone: phone,
        );

        return left(null);
      } on ServerException catch (e) {
        return right(ServerFailure(errorMessage: e.error));
      } on LoginException catch (e) {
        return right(LoginFailure(errorMessage: e.error));
      } catch (e) {
        print(e);
        return right(UndefinedFailure(errorMessage: e.toString()));
      }
    } else {
      return right(ConnectionFailure());
    }
  }

  Future<CustomerModel> _getCustomerWithRequest({
    required final String username,
    required final String password,
    final bool encodePassword = true,
  }) async {
    final CustomerModel customerData =
        await customerRemoteDS.verifyCustomerData(
      username: username,
      password: encodePassword ? Utils.encodeString(value: password) : password,
    );

    final RequestModel request = await requestRemoteDS
        .getOrCreateCustomerRequest(customer: customerData);
    final customer = customerData.copyWith(request: request);

    return customer;
  }
}
