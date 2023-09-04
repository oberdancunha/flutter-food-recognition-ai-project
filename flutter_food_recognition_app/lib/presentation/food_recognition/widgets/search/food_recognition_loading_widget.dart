import 'package:flutter/material.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../image_choosed_widget.dart';
import '../scanner_image/scanner_animation_widget.dart';
import '../scanner_image/scanner_image_border_painter.dart';

class FoodRecognitionLoadingWidget extends StatelessWidget {
  final String base64Image;

  const FoodRecognitionLoadingWidget({
    required this.base64Image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resizeToFrame = EdgeInsets.symmetric(
      horizontal: MediaQuery.sizeOf(context).width * 0.07,
      vertical: MediaQuery.sizeOf(context).height * 0.045,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                child: CustomPaint(
                  painter: ScannerImageBorderPainter(),
                  child: Center(
                    child: Padding(
                      padding: resizeToFrame,
                      child: ImageChoosedWidget(base64Image: base64Image),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: resizeToFrame,
                child: const ClipRRect(
                  child: ScannerWidget(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.1),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.tertiary,
              highlightColor: Theme.of(context).colorScheme.secondary,
              period: const Duration(seconds: 4),
              child: Text(
                'Realizando a análise do prato',
                style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).width * 0.06,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
