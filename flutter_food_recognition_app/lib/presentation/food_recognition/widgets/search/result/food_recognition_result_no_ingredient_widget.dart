import 'package:flutter/material.dart';

class FoodRecognitionNoIngredientWidget extends StatelessWidget {
  const FoodRecognitionNoIngredientWidget({super.key});

  @override
  Widget build(BuildContext context) => Text(
        'Não foi possível detectar os ingredientes desse prato!',
        style: TextStyle(
          fontSize: MediaQuery.sizeOf(context).width * 0.05,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.secondary,
        ),
        textAlign: TextAlign.center,
      );
}
