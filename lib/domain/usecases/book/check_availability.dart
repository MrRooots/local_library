import 'package:dartz/dartz.dart';

import 'package:local_library/core/usecases/usecase.dart';
import 'package:local_library/core/failures/failures.dart';

import 'package:local_library/domain/repositories/book_repository.dart';

class CheckAvailabilityParams {
  final int bookId;

  CheckAvailabilityParams({required this.bookId});
}

class CheckAvailabilityUseCase
    implements UseCase<bool, CheckAvailabilityParams> {
  final BookRepository repository;

  CheckAvailabilityUseCase({required this.repository});

  @override
  Future<Either<bool, Failure>> call(
    final CheckAvailabilityParams params,
  ) async {
    return await repository.checkAvailability(bookId: params.bookId);
  }
}
