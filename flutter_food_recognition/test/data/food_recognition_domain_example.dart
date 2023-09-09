import 'package:flutter_food_recognition/domain/core/food_recognition_id_value_object.dart';
import 'package:flutter_food_recognition/domain/core/food_recognition_name_value_object.dart';
import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';

final foodRecognitionDomain = [
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('meat'),
    score: 0.9525125,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('vegetable'),
    score: 0.93890077,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('tomato'),
    score: 0.9336903,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('sauce'),
    score: 0.9141822,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('beef'),
    score: 0.90578556,
  ),
];
