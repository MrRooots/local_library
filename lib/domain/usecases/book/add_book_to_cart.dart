import 'package:dartz/dartz.dart';

import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/usecases/usecase.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/entities/request_entity.dart';
import 'package:local_library/domain/repositories/cart_repository.dart';

class AddBookToCartParams {
  final CustomerEntity customer;
  final RequestEntity request;
  final BookEntity book;

  AddBookToCartParams({
    required this.customer,
    required this.request,
    required this.book,
  });
}

class AddBookToCartUseCase implements UseCase<void, AddBookToCartParams> {
  final CartRepository repository;

  AddBookToCartUseCase({required this.repository});

  @override
  Future<Either<void, Failure>> call(
    final AddBookToCartParams params,
  ) async {
    return await repository.addBookToRequest(
      customer: params.customer,
      request: params.request,
      book: params.book,
    );
  }
}
