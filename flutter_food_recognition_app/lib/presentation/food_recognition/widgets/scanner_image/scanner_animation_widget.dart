import 'package:flutter/material.dart';

import 'scanner_horizontal_animation_widget.dart';
import 'scanner_vertical_animation_widget.dart';

class ScannerWidget extends StatefulWidget {
  const ScannerWidget({super.key});

  @override
  State<ScannerWidget> createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late bool _horizontalScanner;
  late bool _reverse;

  @override
  void initState() {
    _horizontalScanner = true;
    _reverse = false;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2800),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(
            const Duration(milliseconds: 100),
            () {
              setState(() {
                _reverse = !_reverse;
              });
              _animationController.reverse().whenComplete(() {
                setState(() {
                  _horizontalScanner = !_horizontalScanner;
                  _reverse = !_reverse;
                });
                _animationController
                  ..reset()
                  ..forward(from: 0);
              });
            },
          );
        }
      })
      ..forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScannerAnimationWidget(
        listenable: _animationController,
        horizontalScanner: _horizontalScanner,
        reverse: _reverse,
      );
}

class ScannerAnimationWidget extends AnimatedWidget {
  final bool horizontalScanner;
  final bool reverse;

  const ScannerAnimationWidget({
    required super.listenable,
    required this.horizontalScanner,
    required this.reverse,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) {
          final animation = listenable as Animation<double>;
          final position = (animation.value * constraints.maxWidth) - (constraints.maxWidth * 0.51);

          return Center(
            child: LayoutBuilder(
              builder: (_, constraints) {
                final size = constraints.maxWidth * 0.2;

                return horizontalScanner
                    ? ScannerHorizontalAnimationWidget(
                        position: position,
                        reverse: reverse,
                        width: size,
                      )
                    : ScannerVerticalAnimationWidget(
                        position: position,
                        reverse: reverse,
                        height: size,
                      );
              },
            ),
          );
        },
      );
}
