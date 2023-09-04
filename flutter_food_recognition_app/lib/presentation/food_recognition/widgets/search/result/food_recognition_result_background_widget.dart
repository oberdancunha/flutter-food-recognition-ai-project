import 'package:flutter/material.dart';

class FoodRecognitionResultBackgroundWidget extends StatelessWidget {
  const FoodRecognitionResultBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) => Positioned.fill(
        top: MediaQuery.sizeOf(context).height * 0.15,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
        ),
      );
}
