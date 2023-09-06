import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../../domain/entities/food_recognition.dart';

class FoodRecognitionDto extends Equatable {
  final String name;
  final double score;

  const FoodRecognitionDto({
    required this.name,
    required this.score,
  });

  FoodRecognition toDomain() => FoodRecognition(name: name, score: score);

  @override
  List<Object?> get props => [
        name,
        score,
      ];
}
