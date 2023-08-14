import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

class FoodRecognition extends Equatable {
  final String name;
  final double score;

  const FoodRecognition({
    required this.name,
    required this.score,
  });

  @override
  List<Object?> get props => [
        name,
        score,
      ];
}
