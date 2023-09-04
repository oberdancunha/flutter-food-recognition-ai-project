// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../domain/entities/food_recognition.dart';

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
  final KtList<FoodRecognition> foodRecognitionList;

  const FoodRecognitionSuccessState({
    required this.base64Image,
    required this.foodRecognitionList,
  });

  @override
  bool operator ==(covariant FoodRecognitionSuccessState other) {
    if (identical(this, other)) {
      return true;
    }

    return other.foodRecognitionList == foodRecognitionList;
  }

  @override
  int get hashCode => foodRecognitionList.hashCode;
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
