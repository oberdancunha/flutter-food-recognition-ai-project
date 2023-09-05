import 'package:flutter_food_recognition/module/food_recognition_module.dart';
import 'package:flutter_food_recognition_clarifai/module/food_recognition_clarifai_module.dart';
import 'package:flutter_food_recognition_core/module/food_recognition_core_module.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../food_recognition/main/main.page.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        FoodRecognitionCoreModule(),
        FoodRecognitionClarifaiModule(),
        FoodRecognitionModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const MainPage(),
    );
    super.routes(r);
  }
}
