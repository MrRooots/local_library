import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Any server errors
class ServerFailure extends Failure {
  final String errorMessage;

  ServerFailure({required this.errorMessage});
}

/// Connection errors
class ConnectionFailure extends Failure {}

/// Failed login request
class LoginFailure extends Failure {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

/// No cached session value was found
class CacheFailure extends Failure {
  final String errorMessage;

  CacheFailure({required this.errorMessage});
}

/// Implements all different exceptions
class UndefinedFailure extends Failure {
  final String errorMessage;

  UndefinedFailure({required this.errorMessage});
}
