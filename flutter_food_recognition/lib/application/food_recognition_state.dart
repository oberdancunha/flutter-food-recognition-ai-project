// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';

import '../domain/entities/food_recognition_ingredients.dart';

sealed class FoodRecognitionState {
  const FoodRecognitionState();
}

class FoodRecognitionInitialState extends FoodRecognitionState {
  const FoodRecognitionInitialState();
}

class FoodRecognitionLoadingState extends FoodRecognitionState {
  final String base64Image;

  const FoodRecognitionLoadingState({required this.base64Image});
}

@immutable
class FoodRecognitionSuccessState extends FoodRecognitionState {
  final String base64Image;
  final FoodRecognitionIngredients foodRecognitionIngredients;

  const FoodRecognitionSuccessState({
    required this.base64Image,
    required this.foodRecognitionIngredients,
  });

  @override
  bool operator ==(covariant FoodRecognitionSuccessState other) {
    if (identical(this, other)) {
      return true;
    }

    return other.foodRecognitionIngredients == foodRecognitionIngredients;
  }

  @override
  int get hashCode => foodRecognitionIngredients.hashCode;
}

@immutable
class FoodRecognitionFailureState extends FoodRecognitionState {
  final CoreFailure failure;

  const FoodRecognitionFailureState({
    required this.failure,
  });

  @override
  bool operator ==(covariant FoodRecognitionFailureState other) {
    if (identical(this, other)) {
      return true;
    }

    return other.failure == failure;
  }

  @override
  int get hashCode => failure.hashCode;
}
