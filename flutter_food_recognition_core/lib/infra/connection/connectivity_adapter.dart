import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'connection.dart';

class ConnectivityAdapter implements Connection {
  final Connectivity connectivity;

  ConnectivityAdapter({
    required this.connectivity,
  });

  @override
  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();
    final isConnected = connectivityResult != ConnectivityResult.none;

    return isConnected;
  }
}
