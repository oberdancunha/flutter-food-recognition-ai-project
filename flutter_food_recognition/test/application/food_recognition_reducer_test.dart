import 'package:flutter_food_recognition/application/food_recognition_atom.dart';
import 'package:flutter_food_recognition/application/food_recognition_reducer.dart';
import 'package:flutter_food_recognition/application/food_recognition_state.dart';
import 'package:flutter_food_recognition/infra/gateway/food_recognition_gateway.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data/food_recognition_domain_example.dart';

class MockFoodRecognitionGateway extends Mock implements FoodRecognitionGateway {}

void main() {
  late MockFoodRecognitionGateway mockFoodRecognitionGateway;
  late FoodRecognitionReducer foodRecognitionReducer;

  setUp(() {
    mockFoodRecognitionGateway = MockFoodRecognitionGateway();
    foodRecognitionReducer = FoodRecognitionReducer(
      foodRecognitionGateway: mockFoodRecognitionGateway,
    );
  });

  group('Food Recognition Reducer |', () {
    group('getImageRecognition success |', () {
      void setUpMockGeFoodRecognitionSuccess() {
        when(() => mockFoodRecognitionGateway.getImageRecognition(any())).thenAnswer(
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
          verify(() => mockFoodRecognitionGateway.getImageRecognition(any())).called(1);
          expect(
            foodRecognitionState.value,
            equals(
              FoodRecognitionSuccessState(
                foodRecognition: foodRecognitionDomain.toImmutableList(),
              ),
            ),
          );
        },
      );
    });

    group('getImageRecognition Failure |', () {
      void setUpMockGeFoodRecognitionFailure() {
        when(() => mockFoodRecognitionGateway.getImageRecognition(any())).thenAnswer(
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
          verify(() => mockFoodRecognitionGateway.getImageRecognition(any())).called(1);
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
