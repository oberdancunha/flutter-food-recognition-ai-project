import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../application/food_recognition_reducer.dart';
import '../infra/gateway/food_recognition_gateway.dart';
import '../infra/gateway/food_recognition_gateway_http.dart';

class FoodRecognitionModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addLazySingleton<FoodRecognitionGateway>(FoodRecognitionGatewayHttp.new)
      ..addLazySingleton<FoodRecognitionReducer>(FoodRecognitionReducer.new);
    super.exportedBinds(i);
  }
}
