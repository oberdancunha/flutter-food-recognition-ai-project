import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../../../domain/entities/food_recognition.dart';

abstract interface class FoodRecognitionGateway {
  Future<Result<KtList<FoodRecognition>, CoreFailure>> getImageRecognition(String base64Image);
}
