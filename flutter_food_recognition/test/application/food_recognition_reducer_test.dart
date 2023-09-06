import 'package:flutter_food_recognition/application/food_recognition_atom.dart';
import 'package:flutter_food_recognition/application/food_recognition_reducer.dart';
import 'package:flutter_food_recognition/application/food_recognition_state.dart';
import 'package:flutter_food_recognition/infra/repository/food_recognition_repository.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data/food_recognition_domain_example.dart';

class MockFoodRecognitionRepository extends Mock implements FoodRecognitionRepository {}

void main() {
  late MockFoodRecognitionRepository mockFoodRecognitionRepository;
  late FoodRecognitionReducer foodRecognitionReducer;

  setUp(() {
    mockFoodRecognitionRepository = MockFoodRecognitionRepository();
    foodRecognitionReducer = FoodRecognitionReducer(
      foodRecognitionRepository: mockFoodRecognitionRepository,
    );
  });

  group('Food Recognition Reducer |', () {
    group('getImageRecognition success |', () {
      void setUpMockGeFoodRecognitionSuccess() {
        when(() => mockFoodRecognitionRepository.getImageRecognition(any())).thenAnswer(
          (_) async => Result.success(foodRecognitionDomain.toImmutableList()),
        );
      }

      test(
        'Should change loading state to success state.',
        () async {
          setUpMockGeFoodRecognitionSuccess();
          expect(
            foodRecognitionState.buffer(2),
            completion([
              isA<FoodRecognitionLoadingState>(),
              isA<FoodRecognitionSuccessState>(),
            ]),
          );
          await foodRecognitionReducer.getFoodRecognition('');
        },
      );

      test(
        'Should final state be FoodRecognitionSuccessState with list of recognized foods.',
        () async {
          setUpMockGeFoodRecognitionSuccess();
          await foodRecognitionReducer.getFoodRecognition('');
          verify(() => mockFoodRecognitionRepository.getImageRecognition(any())).called(1);
          expect(
            foodRecognitionState.value,
            equals(
              FoodRecognitionSuccessState(
                base64Image: '',
                foodRecognitionList: foodRecognitionDomain.toImmutableList(),
              ),
            ),
          );
        },
      );
    });

    group('getImageRecognition Failure |', () {
      void setUpMockGeFoodRecognitionFailure() {
        when(() => mockFoodRecognitionRepository.getImageRecognition(any())).thenAnswer(
          (_) async => Result.failure(const ResponseHttpFailure()),
        );
      }

      test('Should change loading state to failure state', () async {
        setUpMockGeFoodRecognitionFailure();
        expect(
          foodRecognitionState.buffer(2),
          completion([
            isA<FoodRecognitionLoadingState>(),
            isA<FoodRecognitionFailureState>(),
          ]),
        );
        await foodRecognitionReducer.getFoodRecognition('');
      });

      test(
        'Should final state be FoodRecognitionFailureState with ResponseHttpFailure argument.',
        () async {
          setUpMockGeFoodRecognitionFailure();
          await foodRecognitionReducer.getFoodRecognition('');
          verify(() => mockFoodRecognitionRepository.getImageRecognition(any())).called(1);
          expect(
            foodRecognitionState.value,
            equals(const FoodRecognitionFailureState(failure: ResponseHttpFailure())),
          );
        },
      );
    });
  });

  tearDownAll(foodRecognitionState.dispose);
}
