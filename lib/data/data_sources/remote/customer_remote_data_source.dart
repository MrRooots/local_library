import 'dart:io';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:local_library/core/constants/constants.dart';
import 'package:local_library/core/constants/types.dart';

import 'package:local_library/core/failures/exceptions.dart';
import 'package:local_library/core/failures/utils.dart';
import 'package:local_library/data/models/customer.dart';
import 'package:local_library/data/models/image.dart';
import 'package:local_library/service_locator.dart';
import 'package:local_library/services/supabase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CustomerRemoteDataSource {
  /// Verify given customer [username] and [password] with database
  ///
  /// Returns [CustomerModel]
  ///
  /// Throws [LoginException] if credentials are invalid
  Future<CustomerModel> getCustomerData({
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
  Future<CustomerModel> getCustomerData({
    required final String username,
    required final String password,
  }) async {
    final http.Response response = await client.get(
      SupabaseApi.buildUrlForTable(
        tableName: 'customer',
        queryParams: {
          'username': 'ilike.${username.toLowerCase()}',
          'password': 'eq.$password',
          'limit': '1',
        },
      ),
      headers: SupabaseApi.getRequestHeaders(singularRecord: true),
    );
    print(
      '''Response valid: 
      Response body: ${response.body}, 
      Status code: ${response.statusCode}
      ''',
    );
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
      response = await http.put(
        url,
        headers: Constants.authHeaders,
        body: await image.imageFileBytes,
      );
    } else {
      response = await http.post(
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
    final http.Response response = await http.get(
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
    return (await http.get(
          SupabaseApi.buildUrlForStorage(filename: filename),
          headers: Constants.authHeaders,
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
    final http.Response response = await http.post(
      SupabaseApi.buildUrlForTable(
        tableName: 'customer',
        queryParams: const {},
      ),
      headers: Constants.authHeaders,
      body: convert.jsonEncode({
        'username': username,
        'password': Utils.encodeString(value: password),
        'name': name,
        'surname': surname,
        'address': address,
        'phone': phone,
      }),
    );

    /// According to
    /// * <https://postgrest.org/en/stable/errors.html#http-status-codes>
    /// postgREST documentation
    if (response.statusCode == 409) {
      throw LoginException('Customer with this credentials already exists!');
    } else if (response.statusCode == 400) {
      throw LoginException('Something went wrong! Check all required fields!');
    } else if (response.statusCode != 201) {
      throw UndefinedException(
        '[CustomerRemoteDataSource]: ${response.body}'
        'Mabye everything alright. Try to login with provided credentials :)',
      );
    }
  }
}
