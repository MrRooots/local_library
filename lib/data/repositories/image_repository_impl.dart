import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_library/domain/repositories/image_repository.dart';

import 'package:local_library/services/network_info.dart';

import 'package:local_library/core/failures/exceptions.dart';
import 'package:local_library/core/failures/failures.dart';

import 'package:local_library/data/models/image.dart';
import 'package:local_library/data/models/customer.dart';

import 'package:local_library/data/data_sources/local/customer_local_data_source.dart';
import 'package:local_library/data/data_sources/remote/customer_remote_data_source.dart';

class ImageRepositoryImpl implements ImageRepository {
  final NetworkInfo networkInfo;
  final CustomerLocalDataSource localDataSource;
  final CustomerRemoteDataSource remoteDataSource;

  const ImageRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<File, Failure>> getCustomerImage() async {
    if (await networkInfo.isConnected) {
      try {
        final CustomerModel customer = await localDataSource.getCachedCustomer;

        final ImageModel image = await remoteDataSource.loadCustomerImage(
          customer: customer,
        );

        return left(image.imageFile);
      } on CacheException catch (error) {
        return right(CacheFailure(errorMessage: error.error));
      } on ServerException catch (error) {
        return right(ServerFailure(errorMessage: error.error));
      } catch (error) {
        return right(UndefinedFailure(errorMessage: error.toString()));
      }
    } else {
      try {
        final ImageModel image = await localDataSource.getCachedImage();

        return left(image.imageFile);
      } on CacheException catch (error) {
        return right(CacheFailure(errorMessage: error.error));
      } catch (error) {
        return right(UndefinedFailure(errorMessage: error.toString()));
      }
    }
  }

  @override
  Future<Either<ImageModel, Failure>> saveImageToCache({
    required final XFile image,
  }) async {
    try {
      final CustomerModel customer = await localDataSource.getCachedCustomer;
      final ImageModel img = await localDataSource.saveImageToCache(
        customer: customer,
        image: image,
      );
      await remoteDataSource.uploadCustomerImage(image: img);
      print('Saved image: $img');

      return left(img);
    } on ServerException catch (error) {
      return right(ServerFailure(errorMessage: error.error));
    } on CacheException catch (error) {
      return right(CacheFailure(errorMessage: error.toString()));
    } catch (error) {
      return right(UndefinedFailure(errorMessage: error.toString()));
    }
  }
}
