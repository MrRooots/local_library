import 'package:equatable/equatable.dart';
import 'package:local_library/data/models/book.dart';
import 'package:local_library/data/models/customer.dart';

class RequestEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime expiredAt;
  final CustomerModel customer;
  final List<BookModel> books;

  /// Constructor
  const RequestEntity({
    required this.id,
    required this.createdAt,
    required this.expiredAt,
    required this.customer,
    this.books = const [],
  });

  @override
  List<Object?> get props => [id, createdAt, expiredAt, customer, books];
}
