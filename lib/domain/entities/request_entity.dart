import 'package:equatable/equatable.dart';
import 'package:local_library/core/constants/types.dart';
import 'package:local_library/data/models/customer.dart';
import 'package:local_library/domain/entities/book_entity.dart';

class RequestEntity extends Equatable {
  final int id;
  final RequestType type;
  final DateTime createdAt;
  final DateTime expiredAt;
  final List<BookEntity> books;

  /// Constructor
  const RequestEntity({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.expiredAt,
    this.books = const [],
  });

  @override
  List<Object?> get props => [id, type, createdAt, expiredAt, books];
}
