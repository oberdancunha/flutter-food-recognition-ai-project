import 'package:flutter/material.dart';

class ScannerHorizontalAnimationWidget extends StatelessWidget {
  final double position;
  final bool reverse;
  final double width;

  const ScannerHorizontalAnimationWidget({
    required this.position,
    required this.reverse,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        transform: Matrix4.translationValues(position, 0, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          gradient: LinearGradient(
            begin: reverse ? Alignment.centerLeft : Alignment.centerRight,
            end: reverse ? Alignment.centerRight : Alignment.centerLeft,
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
