import 'package:flutter/material.dart';

class MainTitleWidget extends StatelessWidget {
  final double fontSize;
  final Color fontColor;

  const MainTitleWidget({
    required this.fontSize,
    required this.fontColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Text(
        'Meu Prato',
        style: TextStyle(
          fontFamily: 'GoodBoy',
          fontSize: fontSize,
          color: fontColor,
          height: 1.1,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
      );
}
