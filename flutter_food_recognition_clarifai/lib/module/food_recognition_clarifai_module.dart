import 'package:flutter_food_recognition_core/data_source/data_source_credentials.dart';
import 'package:flutter_food_recognition_core/data_source/data_source_dto.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../data_source/clarifai_credentials.dart';
import '../data_source/clarifai_data_source_dto.dart';
import '../infra/env/dotenv_adapter.dart';
import '../infra/env/env.dart';

class FoodRecognitionClarifaiModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addSingleton<DotEnv>(DotEnv.new)
      ..addSingleton<Env>(DotEnvAdapter.new)
      ..addLazySingleton<DataSourceCredentials>(ClarifaiCredentials.new)
      ..addLazySingleton<DataSourceDto>(ClarifaiDataSourceDto.new);
    super.exportedBinds(i);
  }
}
