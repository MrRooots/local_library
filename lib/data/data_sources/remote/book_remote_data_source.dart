import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:local_library/core/constants/constants.dart';
import 'package:local_library/core/failures/exceptions.dart';

import 'package:local_library/data/models/book.dart';
import 'package:local_library/services/supabase_api.dart';
import 'package:local_library/services/network_info.dart';

abstract class BookRemoteDataSource {
  /// Request all books from database using provided api
  ///
  /// Returns the list of [BookModel]
  Future<List<BookModel>> getAllBooks();

  /// Request the list of books according to filters
  ///
  /// Returns the list of [BookModel]
  Future<List<BookModel>> getAllBooksWhere({
    final int? id,
    final int offset = 0,
    final int limit = 20,
    final String author = '',
    final List<DateTime?> publishedBetween = const [null, null],
  });

  /// Request the count of remaining books for given [bookId]
  ///
  /// Returns the count of remaining books
  Future<int> getBookRemainsCount({required final int bookId});
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;

  const BookRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BookModel>> getAllBooks() async {
    final http.Response response = await http.get(
      Uri.parse('${Constants.api}/rest/v1/book'),
      headers: Constants.authHeaders,
    );

    return fetchResponse(response: response);
  }

  @override
  Future<List<BookModel>> getAllBooksWhere({
    final int? id,
    final int offset = 0,
    final int limit = 20,
    final String author = '',
    final List<DateTime?> publishedBetween = const [null, null],
  }) async {
    final http.Response response = await http.get(
      SupabaseApi.buildUrlForTable(
        tableName: 'book',
        queryParams: {
          'id': 'eq.$id',
          'offset': '$offset',
          'limit': '$limit',
          'author': 'eq.$author',
        },
      ),
      headers: Constants.authHeaders,
    );

    return fetchResponse(response: response);
  }

  Future<int> getBookRemainsCount({required final int bookId}) async {
    final http.Response response = await http.get(
      SupabaseApi.buildUrlForJoinTables(
        table1: 'book',
        table2: 'registry',
        column1: 'id',
        column2: 'remains',
        whereParams: {'id': 'eq.$bookId'},
      ),
      headers: SupabaseApi.getRequestHeaders(singularRecord: true),
    );

    print(response.body);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final Map<String, dynamic> responseJson = convert.jsonDecode(
        response.body,
      );

      return responseJson['registry'].first['remains'];
    } else {
      throw ServerException('Invalid request or book does not exists!');
    }
  }

  /// Parse list of [BookModel] from given [response]
  List<BookModel> fetchResponse({required final http.Response response}) {
    print('Raw response: ${response.body}');

    return (convert.jsonDecode(response.body) as List)
        .map((final j) => BookModel.fromJson(json: j as Map<String, dynamic>))
        .toList();
  }
}
