import 'dart:io';
import 'dart:convert' as convert;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:local_library/core/constants/constants.dart';
import 'package:local_library/core/failures/exceptions.dart';

import 'package:local_library/data/models/image.dart';
import 'package:local_library/data/models/customer.dart';

abstract class CustomerLocalDataSource {
  /// Load the [CustomerModel] from cache
  ///
  /// Throw [CacheException] if no cached customer data presents
  Future<CustomerModel> get getCachedCustomer;

  /// Save [customer] username and encoded password to cache
  ///
  /// Throw [CacheException] on errors
  Future<void> saveCustomerToCache({required final CustomerModel customer});

  /// Clear saved [CustomerModel] data from device cache
  ///
  /// Throw [CacheException] on errors
  Future<void> clearCache();

  /// Load customer profile image path from lacal storage
  ///
  /// Returns [ImageModel] or [CacheException]
  Future<ImageModel> getCachedImage();

  /// Save selected image [XFile] into documents directory
  ///
  /// Returns [ImageModel] or [Failure]
  Future<ImageModel> saveImageToCache({
    required final CustomerModel customer,
    required final XFile image,
  });
}

class UserLocalDataSourceImpl implements CustomerLocalDataSource {
  final SharedPreferences localStorage;

  const UserLocalDataSourceImpl({required this.localStorage});

  @override
  Future<CustomerModel> get getCachedCustomer {
    final String? customerJsonString =
        localStorage.getString(Constants.cachedCustomer);

    if (customerJsonString != null && customerJsonString.isNotEmpty) {
      return Future.value(
        CustomerModel.fromJson(json: convert.jsonDecode(customerJsonString)),
      );
    } else {
      throw CacheException('No cached user exists');
    }
  }

  @override
  Future<void> saveCustomerToCache({required CustomerModel customer}) async {
    final String customerJson = convert.jsonEncode(customer.toJson());

    await localStorage.setString(Constants.cachedCustomer, customerJson);
  }

  @override
  Future<void> clearCache() async => await localStorage.clear();

  @override
  Future<ImageModel> getCachedImage() async {
    final String? path = localStorage.getString(
      Constants.cachedProfileImagePath,
    );
    if (path != null) {
      return ImageModel(path: path);
    } else {
      throw CacheException('No saved image exists!');
    }
  }

  @override
  Future<ImageModel> saveImageToCache({
    required final CustomerModel customer,
    required final XFile image,
  }) async {
    final Directory documents = await getApplicationDocumentsDirectory();
    final String imagePath =
        '${documents.path}${Platform.pathSeparator}${customer.customerAvatarFilename}';
    await image.saveTo(imagePath);

    await localStorage.setString(Constants.cachedProfileImagePath, imagePath);

    return ImageModel(path: imagePath);
  }
}
