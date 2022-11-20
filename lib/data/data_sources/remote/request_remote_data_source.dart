import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:local_library/core/constants/constants.dart';
import 'package:local_library/core/constants/error_description.dart';
import 'package:local_library/core/failures/exceptions.dart';
import 'package:local_library/data/models/book.dart';
import 'package:local_library/data/models/customer.dart';
import 'package:local_library/data/models/request.dart';
import 'package:local_library/services/supabase_api.dart';

abstract class RequestRemoteDataSource {
  /// Request [customer] cart from database or create the new one
  ///
  /// Throws [ServerException] on error or if cart not found
  ///
  /// Returns [RequestModel]
  Future<RequestModel> getOrCreateCustomerRequest({
    required final CustomerModel customer,
  });

  /// Create new temporary request for [customer] in database
  ///
  /// Throws [ServerException] on error or if cart not found
  ///
  /// Returns [RequestModel]
  Future<RequestModel> createCustomerRequest({
    required final CustomerModel customer,
  });

  /// Get list of [BookModel] associated with given [request]
  ///
  /// Throws [ServerException]
  ///
  /// Returns list of [BookModel]
  Future<List<BookModel>> getRequestBooks({
    required final RequestModel request,
  });
}

class RequestRemoteDatasourceImpl implements RequestRemoteDataSource {
  final http.Client client;

  const RequestRemoteDatasourceImpl({required this.client});

  @override
  Future<RequestModel> getOrCreateCustomerRequest({
    required final CustomerModel customer,
  }) async {
    final http.Response response = await client.get(
      SupabaseApi.buildUrlForFunction(
        function: 'get_customer_temp_request',
        param: '_customer_id=${customer.id}',
      ),
      headers: SupabaseApi.getRequestHeaders(singularRecord: true),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final RequestModel requestData = RequestModel.fromJson(
        json: convert.jsonDecode(response.body),
      );

      return requestData.copyWith(
        books: await getRequestBooks(request: requestData),
      );
    } else {
      return await createCustomerRequest(customer: customer);
    }
  }

  @override
  Future<List<BookModel>> getRequestBooks({
    required final RequestModel request,
  }) async {
    final http.Response response = await client.get(
      SupabaseApi.buildUrlForFunction(
        function: 'get_request_books',
        param: '_request_id=${request.id}',
      ),
      headers: Constants.authHeaders,
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final List<Map<String, dynamic>> responseJson =
          List.from(convert.jsonDecode(response.body));

      return responseJson
          .map((final Map<String, dynamic> json) =>
              BookModel.fromJson(json: json))
          .toList();
    } else {
      return const [];
    }
  }

  @override
  Future<RequestModel> createCustomerRequest({
    required final CustomerModel customer,
  }) async {
    final http.Response response = await client.post(
      SupabaseApi.buildUrlForFunction(function: 'create_new_temp_request'),
      body: convert.jsonEncode({'_customer_id': customer.id}),
      headers: SupabaseApi.getRequestHeaders(singularRecord: true),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return RequestModel.fromJson(json: convert.jsonDecode(response.body));
    } else {
      throw ServerException(ErrorDescription.cartCreationFailed);
    }
  }
}
