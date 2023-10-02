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
          child: Visibility(
            visible: foodRecognitionIngredients.size > 0,
            replacement: const FoodRecognitionNoIngredientWidget(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.02,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.sizeOf(context).width * 0.35,
                  childAspectRatio: MediaQuery.sizeOf(context).height * 0.0022,
                  crossAxisSpacing: MediaQuery.sizeOf(context).width * 0.01,
                  mainAxisSpacing: MediaQuery.sizeOf(context).height * 0.01,
                ),
                shrinkWrap: true,
                itemCount: foodRecognitionIngredients.size,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  final food = foodRecognitionIngredients.elementAt(index);

                  return FoodRecognitionResultIngredientWidget(
                    originalIngredientName: food.name.getOrError(),
                    ingredientName: foodsEnglishToPortuguese[
                            foodRecognitionIngredients.elementAt(index).name.getOrError()]
                        .toString(),
                  );
                },
              ),
            ),
          ),
        ),
      );
}
