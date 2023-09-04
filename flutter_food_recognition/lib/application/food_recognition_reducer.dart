import '../infra/gateway/food_recognition_gateway.dart';
import 'food_recognition_atom.dart';
import 'food_recognition_state.dart';

class FoodRecognitionReducer {
  late final FoodRecognitionGateway _foodRecognitionGateway;

  FoodRecognitionReducer({
    required FoodRecognitionGateway foodRecognitionGateway,
  }) {
    _foodRecognitionGateway = foodRecognitionGateway;
  }

  Future<void> getFoodRecognition(String base64Image) async {
    foodRecognitionState.value = FoodRecognitionLoadingState(base64Image: base64Image);
    final foodRecognitionResult = await _foodRecognitionGateway.getImageRecognition(base64Image);
    foodRecognitionResult.fold(
      (foodRecognition) => foodRecognitionState.value = FoodRecognitionSuccessState(
        base64Image: base64Image,
        foodRecognitionList: foodRecognition,
      ),
      (failure) => foodRecognitionState.value = FoodRecognitionFailureState(failure: failure),
    );
  }
}
