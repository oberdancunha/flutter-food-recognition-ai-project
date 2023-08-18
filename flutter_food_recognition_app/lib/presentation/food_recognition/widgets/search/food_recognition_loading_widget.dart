import 'package:flutter/material.dart';

class FoodRecognitionLoadingWidget extends StatelessWidget {
  const FoodRecognitionLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
