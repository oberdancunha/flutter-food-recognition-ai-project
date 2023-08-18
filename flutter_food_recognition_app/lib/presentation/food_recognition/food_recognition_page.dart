import 'package:flutter/material.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'widgets/food_recognition_body_widget.dart';
import 'widgets/image_source/image_source_choose_widget.dart';

class FoodRecognitionPage extends StatelessWidget {
  const FoodRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: const RxRoot(child: FoodRecognitionBodyWidget()),
          ),
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: ImageSourceChooseWidget(),
        ),
      );
}
