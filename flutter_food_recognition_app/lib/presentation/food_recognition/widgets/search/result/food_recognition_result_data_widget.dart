import 'package:flutter/material.dart';
import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';
import 'package:flutter_food_recognition/utils/foods.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'food_recognition_result_ingredient_widget.dart';

class FoodRecognitionResultDataWidget extends StatelessWidget {
  final KtList<FoodRecognition> foodRecognitionList;

  const FoodRecognitionResultDataWidget({
    required this.foodRecognitionList,
  });

  @override
  Widget build(BuildContext context) => Positioned.fill(
        top: MediaQuery.sizeOf(context).height * 0.35,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height * 0.03),
          child: SingleChildScrollView(
            child: Center(
              child: Wrap(
                spacing: 3,
                runSpacing: 5,
                children: [
                  for (int index = 0; index < foodRecognitionList.size; index++) ...[
                    if (foodsEnglishToPortuguese[
                            foodRecognitionList.elementAt(index).name.getOrError()] !=
                        null)
                      FoodRecognitionResultIngredientWidget(
                        originalIngredientName:
                            foodRecognitionList.elementAt(index).name.getOrError(),
                        ingredientName: foodsEnglishToPortuguese[
                                foodRecognitionList.elementAt(index).name.getOrError()]
                            .toString(),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}
