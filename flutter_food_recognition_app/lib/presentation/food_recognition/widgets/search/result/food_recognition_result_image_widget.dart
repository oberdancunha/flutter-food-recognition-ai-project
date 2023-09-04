import 'package:flutter/material.dart';

import '../../image_choosed_widget.dart';

class FoodRecognitionResultImageWidget extends StatelessWidget {
  final String base64Image;

  const FoodRecognitionResultImageWidget({
    required this.base64Image,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ImageChoosedWidget(
        base64Image: base64Image,
        isCircle: true,
      );
}
