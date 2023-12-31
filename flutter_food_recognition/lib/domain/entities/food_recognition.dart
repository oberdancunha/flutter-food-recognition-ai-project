import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../core/food_recognition_id_value_object.dart';
import '../core/food_recognition_name_value_object.dart';

class FoodRecognition extends Equatable {
  final FoodRecognitionIdValueObject id;
  final FoodRecognitionNameValueObject name;
  final double score;

  const FoodRecognition({
    required this.id,
    required this.name,
    required this.score,
  });

  @override
  List<Object?> get props => [
        name,
        score,
      ];
}
