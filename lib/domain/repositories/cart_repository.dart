import 'package:dartz/dartz.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/entities/request_entity.dart';

abstract class CartRepository {
  // /// Get [customer] temporary request from database
  // ///
  // /// Returns [RequestEntity] or [Failure]
  // Future<Either<RequestEntity, Failure>> getCustomerCart({
  //   required final CustomerEntity customer,
  // });

  /// Add given [book] to [request]
  ///
  /// Returns [void] or [Failure]
  Future<Either<void, Failure>> addBookToRequest({
    required final CustomerEntity customer,
    required final RequestEntity request,
    required final BookEntity book,
  });

  /// Remove given [book] to [request]
  ///
  /// Returns [void] or [Failure]
  Future<Either<void, Failure>> removeBookFromRequest({
    required final CustomerEntity customer,
    required final RequestEntity request,
    required final BookEntity book,
  });

  /// Get books from current [customer] cart
  Future<Either<List<BookEntity>, Failure>> getRequestBooks({
    required final CustomerEntity customer,
  });
}
