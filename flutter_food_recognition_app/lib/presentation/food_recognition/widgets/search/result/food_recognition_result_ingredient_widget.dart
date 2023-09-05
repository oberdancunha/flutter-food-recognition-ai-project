import 'package:flutter/material.dart';

import '../../../../theme/ingredient_theme_extension.dart';

class FoodRecognitionResultIngredientWidget extends StatefulWidget {
  final String originalIngredientName;
  final String ingredientName;

  const FoodRecognitionResultIngredientWidget({
    required this.originalIngredientName,
    required this.ingredientName,
    super.key,
  });

  @override
  State<FoodRecognitionResultIngredientWidget> createState() =>
      _FoodRecognitionResultIngredientWidgetState();
}

class _FoodRecognitionResultIngredientWidgetState
    extends State<FoodRecognitionResultIngredientWidget> {
  late String ingredientImageName;

  @override
  void initState() {
    super.initState();
    ingredientImageName = widget.originalIngredientName.replaceAll(' ', '_');
  }

  @override
  Widget build(BuildContext context) {
    final ingredientThemeExtension = Theme.of(context).extension<IngredientThemeExtension>()!;

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.12,
      width: MediaQuery.sizeOf(context).width / 3.2,
      decoration: BoxDecoration(
        color: ingredientThemeExtension.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/foods/$ingredientImageName.png',
            errorBuilder: (_, __, ___) => Image.asset('assets/images/foods/food.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                widget.ingredientName,
                style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).width * 0.04,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
