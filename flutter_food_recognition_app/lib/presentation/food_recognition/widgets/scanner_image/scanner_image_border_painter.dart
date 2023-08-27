import 'package:flutter/material.dart';

class ScannerImageBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.square
      ..color = Colors.black.withOpacity(0.75);

    canvas
      ..drawPath(_buildHorizontalLineFromTopLeftBorder(size), paint)
      ..drawPath(_buildVerticalLineFromTopLeftBorder(size), paint)
      ..drawPath(_buildHorizontalLineFromBottomLeftBorder(size), paint)
      ..drawPath(_buildVerticalLineFromBottomLeftBorder(size), paint)
      ..drawPath(_buildHorizontalLineFromTopRightBorder(size), paint)
      ..drawPath(_buildVerticalLineFromTopRightBorder(size), paint)
      ..drawPath(_buildHorizontalLineFromBottomRightBorder(size), paint)
      ..drawPath(_buildVerticalLineFromBottomRightBorder(size), paint);
  }

  Path _buildHorizontalLineFromTopLeftBorder(Size size) => Path()
    ..moveTo(size.width * 0.04968944, size.height * 0.05891879)
    ..cubicTo(
      size.width * 0.04968944,
      size.height * 0.05452166,
      size.width * 0.05316553,
      size.height * 0.05095701,
      size.width * 0.05745342,
      size.height * 0.05095701,
    )
    ..lineTo(size.width * 0.3201273, size.height * 0.05095701)
    ..cubicTo(
      size.width * 0.3244130,
      size.height * 0.05095701,
      size.width * 0.3278913,
      size.height * 0.05452166,
      size.width * 0.3278913,
      size.height * 0.05891879,
    )
    ..lineTo(size.width * 0.3278913, size.height * 0.05891879)
    ..cubicTo(
      size.width * 0.3278913,
      size.height * 0.06331592,
      size.width * 0.3244130,
      size.height * 0.06688057,
      size.width * 0.3201273,
      size.height * 0.06688057,
    )
    ..lineTo(size.width * 0.05745342, size.height * 0.06688057)
    ..cubicTo(
      size.width * 0.05316553,
      size.height * 0.06688057,
      size.width * 0.04968944,
      size.height * 0.06331592,
      size.width * 0.04968944,
      size.height * 0.05891879,
    )
    ..lineTo(size.width * 0.04968944, size.height * 0.05891879)
    ..close();

  Path _buildVerticalLineFromTopLeftBorder(Size size) => Path()
    ..moveTo(size.width * 0.05745342, size.height * 0.3362452)
    ..cubicTo(
      size.width * 0.05316553,
      size.height * 0.3362452,
      size.width * 0.04968944,
      size.height * 0.3326783,
      size.width * 0.04968944,
      size.height * 0.3282834,
    )
    ..lineTo(size.width * 0.04968944, size.height * 0.05891720)
    ..cubicTo(
      size.width * 0.04968944,
      size.height * 0.05452006,
      size.width * 0.05316553,
      size.height * 0.05095541,
      size.width * 0.05745342,
      size.height * 0.05095541,
    )
    ..lineTo(size.width * 0.05745342, size.height * 0.05095541)
    ..cubicTo(
      size.width * 0.06174130,
      size.height * 0.05095541,
      size.width * 0.06521739,
      size.height * 0.05452006,
      size.width * 0.06521739,
      size.height * 0.05891720,
    )
    ..lineTo(size.width * 0.06521739, size.height * 0.3282834)
    ..cubicTo(
      size.width * 0.06521739,
      size.height * 0.3326783,
      size.width * 0.06174130,
      size.height * 0.3362452,
      size.width * 0.05745342,
      size.height * 0.3362452,
    )
    ..lineTo(size.width * 0.05745342, size.height * 0.3362452)
    ..close();

  Path _buildHorizontalLineFromBottomLeftBorder(Size size) => Path()
    ..moveTo(size.width * 0.3278913, size.height * 0.9379554)
    ..cubicTo(
      size.width * 0.3278913,
      size.height * 0.9423535,
      size.width * 0.3244130,
      size.height * 0.9459172,
      size.width * 0.3201273,
      size.height * 0.9459172,
    )
    ..lineTo(size.width * 0.05745342, size.height * 0.9459172)
    ..cubicTo(
      size.width * 0.05316553,
      size.height * 0.9459172,
      size.width * 0.04968944,
      size.height * 0.9423535,
      size.width * 0.04968944,
      size.height * 0.9379554,
    )
    ..lineTo(size.width * 0.04968944, size.height * 0.9379554)
    ..cubicTo(
      size.width * 0.04968944,
      size.height * 0.9335573,
      size.width * 0.05316553,
      size.height * 0.9299936,
      size.width * 0.05745342,
      size.height * 0.9299936,
    )
    ..lineTo(size.width * 0.3201273, size.height * 0.9299936)
    ..cubicTo(
      size.width * 0.3244130,
      size.height * 0.9299936,
      size.width * 0.3278913,
      size.height * 0.9335573,
      size.width * 0.3278913,
      size.height * 0.9379554,
    )
    ..lineTo(size.width * 0.3278913, size.height * 0.9379554)
    ..close();

  Path _buildVerticalLineFromBottomLeftBorder(Size size) => Path()
    ..moveTo(size.width * 0.05745342, size.height * 0.9459172)
    ..cubicTo(
      size.width * 0.05316553,
      size.height * 0.9459172,
      size.width * 0.04968944,
      size.height * 0.9423535,
      size.width * 0.04968944,
      size.height * 0.9379554,
    )
    ..lineTo(size.width * 0.04968944, size.height * 0.6685892)
    ..cubicTo(
      size.width * 0.04968944,
      size.height * 0.6641943,
      size.width * 0.05316553,
      size.height * 0.6606274,
      size.width * 0.05745342,
      size.height * 0.6606274,
    )
    ..lineTo(size.width * 0.05745342, size.height * 0.6606274)
    ..cubicTo(
      size.width * 0.06174130,
      size.height * 0.6606274,
      size.width * 0.06521739,
      size.height * 0.6641943,
      size.width * 0.06521739,
      size.height * 0.6685892,
    )
    ..lineTo(size.width * 0.06521739, size.height * 0.9379554)
    ..cubicTo(
      size.width * 0.06521739,
      size.height * 0.9423535,
      size.width * 0.06174130,
      size.height * 0.9459172,
      size.width * 0.05745342,
      size.height * 0.9459172,
    )
    ..lineTo(size.width * 0.05745342, size.height * 0.9459172)
    ..close();

  Path _buildHorizontalLineFromTopRightBorder(Size size) => Path()
    ..moveTo(size.width * 0.6705155, size.height * 0.05897420)
    ..cubicTo(
      size.width * 0.6705155,
      size.height * 0.05457707,
      size.width * 0.6739938,
      size.height * 0.05101242,
      size.width * 0.6782795,
      size.height * 0.05101242,
    )
    ..lineTo(size.width * 0.9409534, size.height * 0.05101242)
    ..cubicTo(
      size.width * 0.9452391,
      size.height * 0.05101242,
      size.width * 0.9487174,
      size.height * 0.05457707,
      size.width * 0.9487174,
      size.height * 0.05897420,
    )
    ..lineTo(size.width * 0.9487174, size.height * 0.05897420)
    ..cubicTo(
      size.width * 0.9487174,
      size.height * 0.06337166,
      size.width * 0.9452391,
      size.height * 0.06693599,
      size.width * 0.9409534,
      size.height * 0.06693599,
    )
    ..lineTo(size.width * 0.6782795, size.height * 0.06693599)
    ..cubicTo(
      size.width * 0.6739938,
      size.height * 0.06693599,
      size.width * 0.6705155,
      size.height * 0.06337166,
      size.width * 0.6705155,
      size.height * 0.05897420,
    )
    ..lineTo(size.width * 0.6705155, size.height * 0.05897420)
    ..close();

  Path _buildVerticalLineFromTopRightBorder(Size size) => Path()
    ..moveTo(size.width * 0.9409534, size.height * 0.05101242)
    ..cubicTo(
      size.width * 0.9452422,
      size.height * 0.05101242,
      size.width * 0.9487174,
      size.height * 0.05457707,
      size.width * 0.9487174,
      size.height * 0.05897420,
    )
    ..lineTo(size.width * 0.9487174, size.height * 0.3283376)
    ..cubicTo(
      size.width * 0.9487174,
      size.height * 0.3327357,
      size.width * 0.9452422,
      size.height * 0.3362994,
      size.width * 0.9409534,
      size.height * 0.3362994,
    )
    ..lineTo(size.width * 0.9409534, size.height * 0.3362994)
    ..cubicTo(
      size.width * 0.9366646,
      size.height * 0.3362994,
      size.width * 0.9331894,
      size.height * 0.3327357,
      size.width * 0.9331894,
      size.height * 0.3283376,
    )
    ..lineTo(size.width * 0.9331894, size.height * 0.05897420)
    ..cubicTo(
      size.width * 0.9331894,
      size.height * 0.05457707,
      size.width * 0.9366646,
      size.height * 0.05101242,
      size.width * 0.9409534,
      size.height * 0.05101242,
    )
    ..lineTo(size.width * 0.9409534, size.height * 0.05101242)
    ..close();

  Path _buildHorizontalLineFromBottomRightBorder(Size size) => Path()
    ..moveTo(size.width * 0.9487174, size.height * 0.9380096)
    ..cubicTo(
      size.width * 0.9487174,
      size.height * 0.9424076,
      size.width * 0.9452422,
      size.height * 0.9459713,
      size.width * 0.9409534,
      size.height * 0.9459713,
    )
    ..lineTo(size.width * 0.6782795, size.height * 0.9459713)
    ..cubicTo(
      size.width * 0.6739938,
      size.height * 0.9459713,
      size.width * 0.6705155,
      size.height * 0.9424076,
      size.width * 0.6705155,
      size.height * 0.9380096,
    )
    ..lineTo(size.width * 0.6705155, size.height * 0.9380096)
    ..cubicTo(
      size.width * 0.6705155,
      size.height * 0.9336146,
      size.width * 0.6739938,
      size.height * 0.9300478,
      size.width * 0.6782795,
      size.height * 0.9300478,
    )
    ..lineTo(size.width * 0.9409534, size.height * 0.9300478)
    ..cubicTo(
      size.width * 0.9452422,
      size.height * 0.9300478,
      size.width * 0.9487174,
      size.height * 0.9336146,
      size.width * 0.9487174,
      size.height * 0.9380096,
    )
    ..lineTo(size.width * 0.9487174, size.height * 0.9380096)
    ..close();

  Path _buildVerticalLineFromBottomRightBorder(Size size) => Path()
    ..moveTo(size.width * 0.9409534, size.height * 0.6606847)
    ..cubicTo(
      size.width * 0.9452422,
      size.height * 0.6606847,
      size.width * 0.9487174,
      size.height * 0.6642516,
      size.width * 0.9487174,
      size.height * 0.6686465,
    )
    ..lineTo(size.width * 0.9487174, size.height * 0.9380127)
    ..cubicTo(
      size.width * 0.9487174,
      size.height * 0.9424108,
      size.width * 0.9452422,
      size.height * 0.9459745,
      size.width * 0.9409534,
      size.height * 0.9459745,
    )
    ..lineTo(size.width * 0.9409534, size.height * 0.9459745)
    ..cubicTo(
      size.width * 0.9366646,
      size.height * 0.9459745,
      size.width * 0.9331894,
      size.height * 0.9424108,
      size.width * 0.9331894,
      size.height * 0.9380127,
    )
    ..lineTo(size.width * 0.9331894, size.height * 0.6686465)
    ..cubicTo(
      size.width * 0.9331894,
      size.height * 0.6642516,
      size.width * 0.9366646,
      size.height * 0.6606847,
      size.width * 0.9409534,
      size.height * 0.6606847,
    )
    ..lineTo(size.width * 0.9409534, size.height * 0.6606847)
    ..close();

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
