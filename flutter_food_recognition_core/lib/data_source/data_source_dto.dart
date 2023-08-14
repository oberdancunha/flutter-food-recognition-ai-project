import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';

abstract interface class DataSourceDto {
  List<FoodRecognition> toFoodRecognitionDomain(Map<String, dynamic> dataSourceImageRecognition);
}
