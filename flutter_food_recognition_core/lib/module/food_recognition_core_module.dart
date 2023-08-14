import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../infra/connection/connection.dart';
import '../infra/connection/connectivity_adapter.dart';
import '../infra/http/http_client.dart';
import '../infra/http/uno_adapter.dart';

class FoodRecognitionCoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addLazySingleton<HttpClient>(UnoAdapter.new)
      ..addLazySingleton<Connection>(ConnectivityAdapter.new);

    super.exportedBinds(i);
  }
}
