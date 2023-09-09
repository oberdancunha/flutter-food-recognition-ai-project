import 'package:flutter_food_recognition_core/domain/value_objects.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../../utils/foods.dart';

class FoodRecognitionNameValueObject extends ValueObjects<String> {
  @override
  final Result<String, void> value;

  factory FoodRecognitionNameValueObject(String name) {
    final nameLowerCase = name.toLowerCase();
    if (!foodsEnglishToPortuguese.containsKey(nameLowerCase)) {
      return FoodRecognitionNameValueObject._(Result.failure(""));
    }

    return FoodRecognitionNameValueObject._(Result.success(nameLowerCase));
  }

  FoodRecognitionNameValueObject._(this.value);
}
