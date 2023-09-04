import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'food_recognition_result_background_widget.dart';
import 'food_recognition_result_data_widget.dart';
import 'food_recognition_result_image_widget.dart';

class FoodRecognitionResultWidget extends StatelessWidget {
  final KtList<FoodRecognition> foodRecognitionList;
  final String base64Image;

  const FoodRecognitionResultWidget({
    required this.foodRecognitionList,
    required this.base64Image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).colorScheme.brightness,
          statusBarIconBrightness: Theme.of(context).colorScheme.brightness,
        ),
      );
    }

    return ColoredBox(
      color: Theme.of(context).colorScheme.secondary,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const FoodRecognitionResultBackgroundWidget(),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.08,
            child: FoodRecognitionResultImageWidget(base64Image: base64Image),
          ),
          FoodRecognitionResultDataWidget(foodRecognitionList: foodRecognitionList),
        ],
      ),
    );
  }
}
