import 'package:flutter/material.dart';
import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';
import 'package:flutter_food_recognition/utils/foods.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'food_recognition_result_ingredient_widget.dart';
import 'food_recognition_result_no_ingredient_widget.dart';

class FoodRecognitionResultDataWidget extends StatelessWidget {
  final KtList<FoodRecognition> foodRecognitionIngredients;

  const FoodRecognitionResultDataWidget({
    required this.foodRecognitionIngredients,
  });

  @override
  Widget build(BuildContext context) => Positioned.fill(
        top: MediaQuery.sizeOf(context).height * 0.35,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height * 0.03,
            bottom: MediaQuery.sizeOf(context).height * 0.018,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: foodRecognitionIngredients.size > 0
                  ? Wrap(
                      spacing: 3,
                      runSpacing: 5,
                      children: [
                        for (int index = 0; index < foodRecognitionIngredients.size; index++) ...[
                          FoodRecognitionResultIngredientWidget(
                            originalIngredientName:
                                foodRecognitionIngredients.elementAt(index).name.getOrError(),
                            ingredientName: foodsEnglishToPortuguese[
                                    foodRecognitionIngredients.elementAt(index).name.getOrError()]
                                .toString(),
                          ),
                        ],
                      ],
                    )
                  : const FoodRecognitionNoIngredientWidget(),
            ),
          ),
        ),
      );
}
