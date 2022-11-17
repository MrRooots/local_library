/// Any server errors
class ServerException implements Exception {
  final String error;

  ServerException(this.error);
}

/// Connection errors like no internet etc.
class ConnectionException implements Exception {
  final String error;

  ConnectionException(this.error);
}

/// Failed login request
class LoginException implements Exception {
  final String error;

  LoginException(this.error);
}

/// No cached session value was found
class CacheException implements Exception {
  final String error;

  CacheException(this.error);
}

/// Implements all different exceptions
class UndefinedException implements Exception {
  final String error;

  UndefinedException(this.error);
}
