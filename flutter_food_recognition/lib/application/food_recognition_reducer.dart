import '../infra/repository/food_recognition_repository.dart';
import 'food_recognition_atom.dart';
import 'food_recognition_state.dart';

class FoodRecognitionReducer {
  late final FoodRecognitionRepository _foodRecognitionRepository;

  FoodRecognitionReducer({
    required FoodRecognitionRepository foodRecognitionRepository,
  }) {
    _foodRecognitionRepository = foodRecognitionRepository;
  }

  Future<void> getFoodRecognition(String base64Image) async {
    foodRecognitionState.value = FoodRecognitionLoadingState(base64Image: base64Image);
    final foodRecognitionResult = await _foodRecognitionRepository.getImageRecognition(base64Image);
    foodRecognitionResult.fold(
      (foodRecognitionIngredients) => foodRecognitionState.value = FoodRecognitionSuccessState(
        base64Image: base64Image,
        foodRecognitionIngredients: foodRecognitionIngredients,
      ),
      (failure) => foodRecognitionState.value = FoodRecognitionFailureState(failure: failure),
    );
  }
}
