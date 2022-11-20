import 'package:local_library/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:local_library/core/usecases/usecase.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/customer_entity.dart';
import 'package:local_library/domain/entities/request_entity.dart';
import 'package:local_library/domain/repositories/cart_repository.dart';

class LoadCustomerCartParams {
  final CustomerEntity customer;

  const LoadCustomerCartParams({required this.customer});
}

class LoadCustomerCartUseCase
    implements UseCase<List<BookEntity>, LoadCustomerCartParams> {
  final CartRepository repository;

  const LoadCustomerCartUseCase({required this.repository});

  @override
  Future<Either<List<BookEntity>, Failure>> call(
    LoadCustomerCartParams params,
  ) async {
    return await repository.getRequestBooks(customer: params.customer);
  }
}
