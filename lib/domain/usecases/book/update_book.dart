import 'package:local_library/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:local_library/core/usecases/usecase.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/repositories/book_repository.dart';

class UpdateBookParams {
  final BookEntity newBok;

  UpdateBookParams({required this.newBok});
}

class UpdateBookUseCase implements UseCase<void, UpdateBookParams> {
  final BookRepository repository;

  const UpdateBookUseCase({required this.repository});

  @override
  Future<Either<void, Failure>> call(UpdateBookParams params) async {
    return await repository.updateBook(newBook: params.newBok);
  }
}
