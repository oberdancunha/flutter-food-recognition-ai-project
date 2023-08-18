import 'package:flutter/material.dart';
import 'package:flutter_food_recognition/application/food_recognition_atom.dart';
import 'package:flutter_food_recognition/application/food_recognition_state.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'main_title_widget.dart';

class FoodRecognitionBodyWidget extends StatelessWidget {
  const FoodRecognitionBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final foodRecognition = context.select(() => foodRecognitionState.value);

    return switch (foodRecognition) {
      FoodRecognitionInitialState() => const MainTitleWidget(),
      FoodRecognitionLoadingState() => const SizedBox.shrink(),
      FoodRecognitionSuccessState() => const SizedBox.shrink(),
      FoodRecognitionFailureState() => const SizedBox.shrink(),
    };
  }
}
