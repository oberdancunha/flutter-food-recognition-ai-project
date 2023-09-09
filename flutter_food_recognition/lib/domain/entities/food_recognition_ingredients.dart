import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'food_recognition.dart';

class FoodRecognitionIngredients extends Equatable {
  final KtList<FoodRecognition> ingredients;

  factory FoodRecognitionIngredients(List<FoodRecognition> foodRecognition) =>
      FoodRecognitionIngredients._(
        foodRecognition
            .where((foodRecognition) => foodRecognition.name.isValid())
            .map((foodRecognition) => foodRecognition)
            .toImmutableList(),
      );

  const FoodRecognitionIngredients._(this.ingredients);

  @override
  List<Object?> get props => [ingredients];
}
