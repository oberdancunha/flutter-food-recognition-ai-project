import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_food_recognition/application/food_recognition_reducer.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'image_source_item.dart';
import 'image_source_option_widget.dart';

class ImageSourceChooseWidget extends StatefulWidget {
  final FoodRecognitionReducer foodRecognitionReducer;

  const ImageSourceChooseWidget({
    required this.foodRecognitionReducer,
    super.key,
  });

  @override
  State<ImageSourceChooseWidget> createState() => _ImageSourceChooseWidgetState();
}

class _ImageSourceChooseWidgetState extends State<ImageSourceChooseWidget> {
  late List<ImageSourceItem> _imageSourceItem;
  late int _bottomNavigationOptionIndex;
  late ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _imageSourceItem = [
      ImageSourceItem(
        key: 'camera',
        title: 'Câmera',
        image: 'food_camera.png',
        imageSource: ImageSource.camera,
      ),
      ImageSourceItem(
        key: 'gallery',
        title: 'Galeria',
        image: 'food_gallery.png',
        imageSource: ImageSource.gallery,
      ),
    ];
    _bottomNavigationOptionIndex = -1;
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.095,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int index = 0; index < _imageSourceItem.length; index++) ...[
              InkWell(
                key: Key(
                  '${_imageSourceItem.elementAt(index).key}_choose_image_resource_button',
                ),
                child: ImageSourceOptionWidget(
                  image: 'assets/images/${_imageSourceItem.elementAt(index).image}',
                  title: _imageSourceItem.elementAt(index).title,
                  isSelected: _bottomNavigationOptionIndex == index,
                ),
                onTap: () async {
                  setState(() {
                    _bottomNavigationOptionIndex = index;
                  });
                  final XFile? image = await _picker.pickImage(
                    source: _imageSourceItem.elementAt(index).imageSource,
                  );
                  if (image != null) {
                    final bytesImage = await io.File(image.path).readAsBytes();
                    final base64Image = base64Encode(bytesImage);
                    widget.foodRecognitionReducer.getFoodRecognition(base64Image);
                  }
                },
              ),
            ],
          ],
        ),
      );
}
