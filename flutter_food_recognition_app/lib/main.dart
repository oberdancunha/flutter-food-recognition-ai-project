import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_food_recognition_core/infra/http/http_overrides_for_old_android_7.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'presentation/core/app_module.dart';
import 'presentation/core/app_widget.dart';

void main() {
  HttpOverrides.global = HttpOverridesForOldAndroid7();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
