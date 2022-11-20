import 'package:local_library/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:local_library/core/usecases/usecase.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/entities/request_entity.dart';
import 'package:local_library/domain/repositories/cart_repository.dart';

class RemoveBookFromCartParams {
  final CustomerEntity customer;
  final RequestEntity request;
  final BookEntity book;

  RemoveBookFromCartParams({
    required this.customer,
    required this.request,
    required this.book,
  });
}

class RemoveBookFromCartUseCase
    implements UseCase<void, RemoveBookFromCartParams> {
  final CartRepository repository;

  RemoveBookFromCartUseCase({required this.repository});

  @override
  Future<Either<void, Failure>> call(
    final RemoveBookFromCartParams params,
  ) async {
    return await repository.removeBookFromRequest(
      customer: params.customer,
      request: params.request,
      book: params.book,
    );
  }
}
