import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../../../../theme/ingredient_theme_extension.dart';
import '../../../main/main_title_widget.dart';
import 'food_recognition_result_background_widget.dart';
import 'food_recognition_result_data_widget.dart';
import 'food_recognition_result_image_widget.dart';

class FoodRecognitionResultWidget extends StatelessWidget {
  final KtList<FoodRecognition> foodRecognitionIngredients;
  final String base64Image;

  const FoodRecognitionResultWidget({
    required this.foodRecognitionIngredients,
    required this.base64Image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ingredientThemeExtension = Theme.of(context).extension<IngredientThemeExtension>()!;

    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: ingredientThemeExtension.brightness,
          statusBarIconBrightness: ingredientThemeExtension.brightness,
        ),
      );
    }

    return ColoredBox(
      color: Theme.of(context).colorScheme.secondary,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.06,
            left: MediaQuery.sizeOf(context).height * 0.015,
            child: MainTitleWidget(
              fontSize: MediaQuery.sizeOf(context).width * 0.09,
              fontColor: Theme.of(context).textTheme.titleSmall!.color!,
            ),
          ),
          const FoodRecognitionResultBackgroundWidget(),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.08,
            child: FoodRecognitionResultImageWidget(base64Image: base64Image),
          ),
          FoodRecognitionResultDataWidget(foodRecognitionIngredients: foodRecognitionIngredients),
        ],
      ),
    );
  }
}
