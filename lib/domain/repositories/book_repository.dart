import 'package:dartz/dartz.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/data/models/book.dart';
import 'package:local_library/domain/entities/book_entity.dart';

abstract class BookRepository {
  /// Request for list of [BookModel] from [BookRemoteDataSource]
  ///
  /// Returns list of [BookEntity] on success and specific [Failure] on error
  Future<Either<List<BookEntity>, Failure>> getBooks();

  /// Request for list of [BookEntity] from [BookRemoteDataSource] with filters
  ///
  /// Returns list of [BookEntity] on success and specific [Failure] on error
  Future<Either<List<BookEntity>, Failure>> getBooksWhere({
    final int? id,
    final int offset = 0,
    final int limit = 20,
    final String author = '',
    final List<DateTime?> publishedBetween = const [null, null],
  });

  /// Update existing [BookEntity] in database
  ///
  /// Returns updated [BookEntity] on success and specific [Failure] on error
  Future<Either<BookEntity, Failure>> updateModel({
    required final BookEntity newBook,
  });

  /// Check if book with given [bookId] is available in library
  ///
  /// Returns [bool] on successfull request and [Failure] on error
  Future<Either<bool, Failure>> checkAvailability({required final int bookId});
}
