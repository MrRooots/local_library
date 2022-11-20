import 'package:dartz/dartz.dart';
import 'package:local_library/data/data_sources/remote/request_remote_data_source.dart';
import 'package:local_library/data/models/customer.dart';
import 'package:local_library/data/models/request.dart';
import 'package:local_library/domain/entities/book_entity.dart';

import 'package:local_library/services/network_info.dart';

import 'package:local_library/core/failures/exceptions.dart';
import 'package:local_library/core/failures/failures.dart';

import 'package:local_library/data/data_sources/remote/cart_remote_data_source.dart';

import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/entities/request_entity.dart';
import 'package:local_library/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource cartRemoteDS;
  final RequestRemoteDataSource requestRemoteDS;
  final NetworkInfo networkInfo;

  const CartRepositoryImpl({
    required this.requestRemoteDS,
    required this.cartRemoteDS,
    required this.networkInfo,
  });

  @override
  Future<Either<void, Failure>> addBookToRequest({
    required final CustomerEntity customer,
    required final RequestEntity request,
    required final BookEntity book,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await cartRemoteDS.addBookToRequest(
          request: request,
          book: book,
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

  @override
  Future<Either<void, Failure>> removeBookFromRequest({
    required final CustomerEntity customer,
    required final RequestEntity request,
    required final BookEntity book,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await cartRemoteDS.removeBookFromRequest(
          request: request,
          book: book,
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

  @override
  Future<Either<List<BookEntity>, Failure>> getRequestBooks({
    required CustomerEntity customer,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final RequestModel request = await requestRemoteDS
            .getOrCreateCustomerRequest(customer: customer as CustomerModel);

        return left(request.books);
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
}
