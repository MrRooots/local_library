import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:local_library/core/constants/constants.dart';
import 'package:local_library/core/failures/exceptions.dart';
import 'package:local_library/core/failures/utils.dart';
import 'package:local_library/data/models/customer.dart';
import 'package:local_library/data/models/image.dart';
import 'package:local_library/services/supabase_api.dart';

abstract class CustomerRemoteDataSource {
  /// Verify given customer [username] and [password] with database
  ///
  /// Returns [CustomerModel]
  ///
  /// Throws [LoginException] if credentials are invalid
  Future<CustomerModel> verifyCustomerData({
    required final String username,
    required final String password,
  });

  /// Register new customer account useng provided data
  ///
  /// Returns [void]
  ///
  /// Throws [ServerException] or [LoginException] on failures
  Future<void> registerCustomer({
    required final String username,
    required final String password,
    required final String name,
    required final String surname,
    required final String address,
    required final String phone,
  });

  /// Upload given [CustomerModel] image to remote storage
  ///
  /// Returns [ImageModel]
  ///
  /// Throws [ServerException] if credentials are invalid
  Future<ImageModel> uploadCustomerImage({required final ImageModel image});

  /// Load [customer] image from database
  Future<ImageModel> loadCustomerImage({required final CustomerModel customer});
}

class CustomerRemoteDataSourceImpl<Model> implements CustomerRemoteDataSource {
  final http.Client client;

  const CustomerRemoteDataSourceImpl({required this.client});

  @override
  Future<CustomerModel> verifyCustomerData({
    required final String username,
    required final String password,
  }) async {
    final http.Response response = await client.get(
      SupabaseApi.buildUrlForFunction(
        function: 'get_customer_data',
        param: '_username=$username&_password=$password',
      ),
      headers: SupabaseApi.getRequestHeaders(singularRecord: true),
    );

    print(response.body);

    if (response.body.isNotEmpty && response.statusCode == 200) {
      final Map<String, dynamic> responseJson =
          convert.jsonDecode(response.body);

      return CustomerModel.fromJson(json: responseJson);
    } else {
      throw LoginException('Invalid username or password!');
    }
  }

  @override
  Future<ImageModel> uploadCustomerImage({
    required final ImageModel image,
  }) async {
    final Uri url = SupabaseApi.buildUrlForStorage(filename: image.filename);
    http.Response response;

    if (await isFileExists(image.filename)) {
      response = await client.put(
        url,
        headers: Constants.authHeaders,
        body: await image.imageFileBytes,
      );
    } else {
      response = await client.post(
        url,
        headers: Constants.authHeaders,
        body: await image.imageFileBytes,
      );
    }

    if (response.statusCode == 200) {
      return image;
    } else {
      throw ServerException('Failed to upload image!');
    }
  }

  @override
  Future<ImageModel> loadCustomerImage({
    required final CustomerModel customer,
  }) async {
    final http.Response response = await client.get(
      SupabaseApi.buildUrlForStorage(
        filename: customer.customerAvatarFilename,
      ),
      headers: Constants.authHeaders,
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return ImageModel.fromStream(
        fileName: customer.customerAvatarFilename,
        bytes: response.bodyBytes,
      );
    } else {
      throw ServerException('Failed to load avatar image!');
    }
  }

  Future<bool> isFileExists(final String filename) async {
    return (await client.get(
          SupabaseApi.buildUrlForStorage(filename: filename),
          headers: SupabaseApi.getRequestHeaders(singularRecord: true),
        ))
            .statusCode ==
        200;
  }

  @override
  Future<void> registerCustomer({
    required final String username,
    required final String password,
    required final String name,
    required final String surname,
    required final String address,
    required final String phone,
  }) async {
    final http.Response response = await client.post(
      SupabaseApi.buildUrlForFunction(function: 'register_customer'),
      headers: SupabaseApi.getRequestHeaders(),
      body: convert.jsonEncode({
        '_username': username,
        '_password': Utils.encodeString(value: password),
        '_name': name,
        '_surname': surname,
        '_address': address,
        '_phone': phone,
      }),
    );

    /// According to
    /// * <https://postgrest.org/en/stable/errors.html#http-status-codes>
    /// postgREST documentation
    if (response.statusCode == 409) {
      throw LoginException('Customer with this credentials already exists!');
    } else if (response.statusCode == 400) {
      throw LoginException('Something went wrong! Check all required fields!');
    } else if (response.statusCode != 201 &&
        response.statusCode != 200 &&
        response.statusCode != 204) {
      throw UndefinedException(
        '[CustomerRemoteDataSource]: ${response.body}'
        'Mabye everything alright. Try to login with provided credentials :)',
      );
    }
  }
}
