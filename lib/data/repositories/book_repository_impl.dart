import 'package:dartz/dartz.dart';
import 'package:local_library/core/failures/exceptions.dart';

import 'package:local_library/core/failures/failures.dart';

import 'package:local_library/data/data_sources/remote/book_remote_data_source.dart';
import 'package:local_library/data/models/book.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  const BookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<List<BookEntity>, Failure>> getBooks() async {
    try {
      final List<BookModel> books = await remoteDataSource.getAllBooks();

      return left(books);
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
  Future<Either<List<BookEntity>, Failure>> getBooksWhere({
    int? id,
    int offset = 0,
    int limit = 20,
    String author = '',
    List<DateTime?> publishedBetween = const [null, null],
  }) async {
    try {
      final List<BookModel> books = await remoteDataSource.getAllBooksWhere(
        id: id,
        offset: offset,
        limit: limit,
        author: author,
        publishedBetween: publishedBetween,
      );

      print('Loaded ${books.length} books');

      return left(books);
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
  Future<Either<BookEntity, Failure>> updateModel({
    required final BookEntity newBook,
  }) async {
    try {
      final List<BookModel> books = await remoteDataSource.getAllBooks();

      return left(books.first);
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
  Future<Either<bool, Failure>> checkAvailability({required int bookId}) async {
    try {
      final int remainingCount = await remoteDataSource.getBookRemainsCount(
        bookId: bookId,
      );

      return left(remainingCount > 0);
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
  Future<Either<void, Failure>> updateBook({
    required BookEntity newBook,
  }) async {
    try {
      await remoteDataSource.updateBook(book: newBook as BookModel);
      print('load');
      return left(null);
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
}
