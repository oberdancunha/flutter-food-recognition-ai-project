import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageChoosedWidget extends StatefulWidget {
  final String base64Image;
  final bool? isCircle;

  const ImageChoosedWidget({
    required this.base64Image,
    this.isCircle = false,
    super.key,
  });

  @override
  State<ImageChoosedWidget> createState() => _ImageChoosedWidgetState();
}

class _ImageChoosedWidgetState extends State<ImageChoosedWidget> {
  late Uint8List _bytesImage;

  @override
  void initState() {
    super.initState();
    _bytesImage = const Base64Codec().decode(widget.base64Image);
  }

  @override
  Widget build(BuildContext context) => widget.isCircle == true
      ? CircleAvatar(
          backgroundImage: MemoryImage(_bytesImage),
          radius: MediaQuery.sizeOf(context).width * 0.25,
        )
      : Image.memory(_bytesImage);
}
