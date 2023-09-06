import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../application/food_recognition_reducer.dart';
import '../data_source/food_recognition_data_source_http.dart';
import '../infra/repository/food_recognition_repository.dart';
import '../infra/repository/food_recognition_repository_http.dart';

class FoodRecognitionModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addLazySingleton<FoodRecognitionDataSourceHttp>(FoodRecognitionDataSourceHttp.new)
      ..addLazySingleton<FoodRecognitionRepository>(FoodRecognitionRepositoryHttp.new)
      ..addLazySingleton<FoodRecognitionReducer>(FoodRecognitionReducer.new);
    super.exportedBinds(i);
  }
}
