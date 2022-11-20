import 'dart:convert' as convert;

import 'package:crypto/crypto.dart' as crypto;

import 'package:local_library/core/constants/types.dart';

import 'package:local_library/core/failures/failures.dart';

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

  static RequestType parseType(final String type) {
    switch (type) {
      case 'temp':
        return RequestType.temp;
      case 'active':
        return RequestType.active;
      case 'closed':
        return RequestType.closed;
      default:
        return RequestType.temp;
    }
  }

  static CustomerStatus parseStatus(final String status) {
    switch (status) {
      case 'user':
        return CustomerStatus.user;
      case 'admin':
        return CustomerStatus.admin;
      case 'moderator':
        return CustomerStatus.moderator;
      default:
        return CustomerStatus.undefined;
    }
  }
}
