import 'package:flutter_food_recognition_core/domain/value_objects.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

class FoodRecognitionNameValueObject extends ValueObjects<String> {
  @override
  final Result<String, void> value;

  factory FoodRecognitionNameValueObject(String name) =>
      FoodRecognitionNameValueObject._(Result.success(name.toLowerCase()));

  FoodRecognitionNameValueObject._(this.value);
}
