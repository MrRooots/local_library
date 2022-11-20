import 'dart:convert';

import 'package:local_library/core/constants/types.dart';
import 'package:local_library/core/failures/utils.dart';
import 'package:local_library/data/models/book.dart';
import 'package:local_library/domain/entities/request_entity.dart';

class RequestModel extends RequestEntity {
  /// Constructor
  const RequestModel({
    required int id,
    required RequestType type,
    required DateTime createdAt,
    required DateTime expiredAt,
    List<BookModel> books = const [],
  }) : super(
          id: id,
          type: type,
          createdAt: createdAt,
          expiredAt: expiredAt,
          books: books,
        );

  @override
  List<Object?> get props => [id, createdAt, expiredAt, books];

  factory RequestModel.fromJson({required final Map<String, dynamic> json}) =>
      RequestModel(
        id: json['id'],
        type: Utils.parseType(json['type']),
        createdAt: DateTime.parse(json['created_at']),
        expiredAt: DateTime.parse(json['expired_at']),
        books: const [],
      );

  factory RequestModel.empty() => RequestModel(
        id: 0,
        type: RequestType.temp,
        createdAt: DateTime.now(),
        expiredAt: DateTime.now(),
        books: const [],
      );

  RequestModel copyWith({
    int? id,
    RequestType? type,
    DateTime? createdAt,
    DateTime? expiredAt,
    List<BookModel>? books,
  }) =>
      RequestModel(
        id: id ?? this.id,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        expiredAt: expiredAt ?? this.expiredAt,
        books: books ?? this.books as List<BookModel>,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.toString().split('.').last,
        'created_at': createdAt.toIso8601String(),
        'expired_at': expiredAt.toIso8601String(),
        'books': jsonEncode(
          books.map((e) => (e as BookModel).toJson()).toList(),
        ),
      };
}
