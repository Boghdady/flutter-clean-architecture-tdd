import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  // getter
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker);

  @override
  Future<bool> get isConnected => null;
}
