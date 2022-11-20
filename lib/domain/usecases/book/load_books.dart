import 'package:dartz/dartz.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/usecases/usecase.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/repositories/book_repository.dart';

class LoadBooksParams {
  final int? id;
  final int offset;
  final int limit;
  final String author;
  final List<DateTime?> publishedBetween;

  const LoadBooksParams({
    this.id,
    this.offset = 0,
    this.limit = 10,
    this.author = '',
    this.publishedBetween = const [null, null],
  });
}

class LoadBooks implements UseCase<List<BookEntity>, LoadBooksParams> {
  final BookRepository repository;

  const LoadBooks({required this.repository});

  @override
  Future<Either<List<BookEntity>, Failure>> call(
    final LoadBooksParams params,
  ) async {
    return await repository.getBooksWhere(
      id: params.id,
      offset: params.offset,
      limit: params.limit,
      author: params.author,
      publishedBetween: params.publishedBetween,
    );
  }
}
