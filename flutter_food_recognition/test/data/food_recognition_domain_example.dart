import 'package:flutter_food_recognition/domain/core/food_recognition_id_value_object.dart';
import 'package:flutter_food_recognition/domain/core/food_recognition_name_value_object.dart';
import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';

final foodRecognitionDomain = [
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('beef'),
    score: 0.98414236,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('french fries'),
    score: 0.97421426,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('meat'),
    score: 0.9669458,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('pork'),
    score: 0.95417833,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('lamb'),
    score: 0.9479489,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('rice'),
    score: 0.938121,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('meal'),
    score: 0.928849,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('chicken'),
    score: 0.8962893,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('potato'),
    score: 0.8893758,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('vegetable'),
    score: 0.8842077,
  ),
  FoodRecognition(
    id: FoodRecognitionIdValueObject(),
    name: FoodRecognitionNameValueObject('pepper'),
    score: 0.8605903,
  ),
];
