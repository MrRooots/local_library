import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:local_library/core/failures/exceptions.dart';
import 'package:local_library/domain/entities/book_entity.dart';
import 'package:local_library/domain/entities/request_entity.dart';
import 'package:local_library/services/supabase_api.dart';

abstract class CartRemoteDataSource {
  /// Add given [book] to [request]
  ///
  /// Throws [ServerException]
  ///
  /// Returns [void]
  Future<void> addBookToRequest({
    required final RequestEntity request,
    required final BookEntity book,
  });

  /// Remove given [book] to [request]
  ///
  /// Throws [ServerException]
  ///
  /// Returns [void]
  Future<void> removeBookFromRequest({
    required final RequestEntity request,
    required final BookEntity book,
  });
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;

  CartRemoteDataSourceImpl({required this.client});

  @override
  Future<void> removeBookFromRequest({
    required final RequestEntity request,
    required final BookEntity book,
  }) async {
    await client.post(
      SupabaseApi.buildUrlForFunction(function: 'remove_book_from_request'),
      body: convert.jsonEncode({
        '_request_id': request.id,
        '_book_id': book.id,
      }),
      headers: SupabaseApi.getRequestHeaders(),
    );
  }

  @override
  Future<void> addBookToRequest({
    required final RequestEntity request,
    required final BookEntity book,
  }) async {
    print('Adding: ${book.id}, ${request.id}');
    final http.Response response = await client.post(
      SupabaseApi.buildUrlForFunction(function: 'append_book_to_request'),
      body: convert.jsonEncode({
        '_request_id': request.id,
        '_book_id': book.id,
      }),
      headers: SupabaseApi.getRequestHeaders(),
    );
    print(response.body);
  }
}
