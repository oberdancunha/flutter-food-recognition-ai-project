import 'package:flutter/material.dart';

class ScannerVerticalAnimationWidget extends StatelessWidget {
  final double position;
  final bool reverse;
  final double height;

  const ScannerVerticalAnimationWidget({
    required this.position,
    required this.reverse,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        transform: Matrix4.translationValues(0, position, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          gradient: LinearGradient(
            begin: reverse ? Alignment.topCenter : Alignment.bottomCenter,
            end: reverse ? Alignment.bottomCenter : Alignment.topCenter,
            stops: const [
              0.0,
              0.2,
              0.9,
              0.95,
              1,
            ],
            colors: [
              Theme.of(context).colorScheme.tertiary.withOpacity(0.05),
              Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
              Theme.of(context).colorScheme.tertiary.withOpacity(0.4),
              Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.tertiary,
            ],
          ),
        ),
      );
}
