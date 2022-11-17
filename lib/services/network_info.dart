import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  /// Check if device is connected to network
  ///
  /// Returns [bool]
  Future<bool> get isConnected;
}

class NetworkInfoImplementation implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImplementation(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
