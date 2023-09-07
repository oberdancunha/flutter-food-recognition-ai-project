import 'package:flutter_food_recognition_core/domain/value_objects.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

class FoodRecognitionIdValueObject extends ValueObjects<String> {
  @override
  final Result<String, void> value;

  factory FoodRecognitionIdValueObject() => FoodRecognitionIdValueObject._(
        Result.success(const Uuid().v1()),
      );

  FoodRecognitionIdValueObject._(this.value);
}
