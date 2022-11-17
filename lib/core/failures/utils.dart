import 'dart:convert' as convert;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:local_library/core/failures/failures.dart';
import 'package:local_library/core/themes/palette.dart';

/// Common utilities
class Utils {
  /// Encode given [value] using md5 algorithm
  ///
  /// Returns [String] the encoded value
  static String encodeString({required final String value}) {
    return crypto.md5.convert(convert.utf8.encode(value)).toString();
  }

  /// Map given [failure] into [String] message
  ///
  /// Return [String] the [failure] description
  static String mapFailureToString({required final Failure failure}) {
    if (failure is LoginFailure) {
      return failure.errorMessage;
    } else if (failure is ServerFailure) {
      return failure.errorMessage;
    } else if (failure is CacheFailure) {
      return failure.errorMessage;
    } else if (failure is UndefinedFailure) {
      return failure.errorMessage;
    } else if (failure is ConnectionFailure) {
      return 'Ошибка подключения к серверу! Похоже, вы не подключены к сети!';
    } else {
      return failure.toString();
    }
  }
}
