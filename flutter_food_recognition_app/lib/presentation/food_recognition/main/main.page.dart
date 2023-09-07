import 'package:flutter/material.dart';
import 'package:flutter_food_recognition/application/food_recognition_reducer.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../widgets/food_recognition_body_widget.dart';
import '../widgets/image_source/image_source_choose_widget.dart';

class MainPage extends StatelessWidget {
  final FoodRecognitionReducer foodRecognitionReducer;

  const MainPage({
    required this.foodRecognitionReducer,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: const RxRoot(child: FoodRecognitionBodyWidget()),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ImageSourceChooseWidget(
            foodRecognitionReducer: foodRecognitionReducer,
          ),
        ),
      );
}
