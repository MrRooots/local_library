import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import 'package:local_library/core/failures/failures.dart';

import 'package:local_library/data/models/image.dart';

abstract class ImageRepository {
  /// Load customer profile image from lacal storage
  ///
  /// Returns [String] path to the file or [Failure]
  Future<Either<File, Failure>> getCustomerImage();

  /// Save selected image [XFile] into documents directory
  ///
  /// Returns [ImageModel] or [Failure]
  Future<Either<ImageModel, Failure>> saveImageToCache({
    required final XFile image,
  });
}
