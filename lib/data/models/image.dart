import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:local_library/domain/entities/image_entity.dart';
import 'package:path_provider/path_provider.dart';

class ImageModel extends ImageEntity {
  const ImageModel({required super.path});

  /// Get image as [File]
  File get imageFile => File(path);

  /// Get image file as a list of bytes
  Future<Uint8List> get imageFileBytes async => await imageFile.readAsBytes();

  String get filename => path.split('/').last;

  /// Build [ImageModel] from given [bytes]
  ///
  /// Returns new [ImageModel] with specified [path] that contains image
  static Future<ImageModel> fromStream({
    required final String fileName,
    required final Uint8List bytes,
  }) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path + Platform.pathSeparator + fileName;

    await File(path).writeAsBytes(bytes);

    return ImageModel(path: path);
  }
}
