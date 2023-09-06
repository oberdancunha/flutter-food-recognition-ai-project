import 'package:flutter_food_recognition/infra/repository/food_recognition_dto.dart';

abstract interface class DataSourceDto {
  List<FoodRecognitionDto> toFoodRecognitionDto(Map<String, dynamic> dataSourceImageRecognition);
}
