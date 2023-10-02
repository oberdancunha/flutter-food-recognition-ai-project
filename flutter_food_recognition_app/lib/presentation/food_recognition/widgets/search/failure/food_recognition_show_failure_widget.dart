import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../main/main_title_widget.dart';

class FoodRecognitionShowFailureWidget extends StatelessWidget {
  final String image;
  final String message;

  const FoodRecognitionShowFailureWidget({
    required this.image,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).colorScheme.brightness,
          statusBarIconBrightness: Theme.of(context).colorScheme.brightness,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: MainTitleWidget(
          fontSize: MediaQuery.sizeOf(context).width * 0.09,
          fontColor: Theme.of(context).textTheme.titleSmall!.color!,
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.42,
            child: Image.asset(
              'assets/images/failure/$image',
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.05,
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: MediaQuery.sizeOf(context).width * 0.047,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
