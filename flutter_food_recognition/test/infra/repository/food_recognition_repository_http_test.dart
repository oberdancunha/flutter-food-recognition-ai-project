import 'package:flutter_food_recognition/data_source/food_recognition_data_source_http.dart';
import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';
import 'package:flutter_food_recognition/infra/repository/food_recognition_repository_http.dart';
import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_core/infra/connection/connection.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/food_recognition_domain_example.dart';
import '../../data/food_recognition_dto_example.dart';

class MockConnection extends Mock implements Connection {}

class MockFoodRecognitionDataSourceHttp extends Mock implements FoodRecognitionDataSourceHttp {}

void main() {
  late MockConnection mockConnection;
  late MockFoodRecognitionDataSourceHttp mockFoodRecognitionDataSourceHttp;
  late FoodRecognitionRepositoryHttp foodRecognitionRepositoryHttp;

  setUp(() {
    mockConnection = MockConnection();
    mockFoodRecognitionDataSourceHttp = MockFoodRecognitionDataSourceHttp();
    foodRecognitionRepositoryHttp = FoodRecognitionRepositoryHttp(
      connection: mockConnection,
      foodRecognitionDataSourceHttp: mockFoodRecognitionDataSourceHttp,
    );
  });

  group(
    'Food Recognition Repository HTTP |',
    () {
      void setUpMockCheckConnectionFalse() {
        when(() => mockConnection.isConnected()).thenAnswer((_) async => false);
      }

      void setUpMockCheckConnectionTrue() {
        when(() => mockConnection.isConnected()).thenAnswer((_) async => true);
      }

      group('Check Connection |', () {
        test('Should return a Failure(ConnectionFailure) when device is not connected', () async {
          setUpMockCheckConnectionFalse();
          final foodRecognition = await foodRecognitionRepositoryHttp.getImageRecognition("");
          verify(mockConnection.isConnected).called(1);
          expect(foodRecognition.isError(), isTrue);
          expect(foodRecognition.exceptionOrNull(), isA<CoreFailure>());
          expect(foodRecognition.exceptionOrNull(), isA<ConnectionFailure>());
        });
      });

      group('Is Connected', () {
        group('Http Authenticaton Error |', () {
          test(
            'Should return Failure(AuthenticationCredentialsFailure) when some http credentials are missing',
            () async {
              setUpMockCheckConnectionTrue();
              when(() => mockFoodRecognitionDataSourceHttp.getFoodRecognition(any())).thenThrow(
                const AuthenticationCredentialsException(),
              );
              final foodRecognition = await foodRecognitionRepositoryHttp.getImageRecognition("");
              expect(foodRecognition.isError(), isTrue);
              expect(foodRecognition.exceptionOrNull(), isA<CoreFailure>());
              expect(foodRecognition.exceptionOrNull(), isA<AuthenticationCredentialsFailure>());
            },
          );
        });

        group('Http Error |', () {
          test(
            'Should return Failure(UnexpectedHttpFailure) when there is an unexpected http exception',
            () async {
              setUpMockCheckConnectionTrue();
              when(
                () => mockFoodRecognitionDataSourceHttp.getFoodRecognition(any()),
              ).thenThrow(const UnexpectedHttpException());
              final foodRecognition = await foodRecognitionRepositoryHttp.getImageRecognition("");
              expect(foodRecognition.isError(), isTrue);
              expect(foodRecognition.exceptionOrNull(), isA<CoreFailure>());
              expect(foodRecognition.exceptionOrNull(), isA<UnexpectedHttpFailure>());
            },
          );

          test(
            'Should return Failure(ResponseHttpFailure) when there is response http exception',
            () async {
              setUpMockCheckConnectionTrue();
              when(
                () => mockFoodRecognitionDataSourceHttp.getFoodRecognition(any()),
              ).thenThrow(const ResponseHttpException());
              final foodRecognition = await foodRecognitionRepositoryHttp.getImageRecognition('');
              expect(foodRecognition.isError(), isTrue);
              expect(foodRecognition.exceptionOrNull(), isA<CoreFailure>());
              expect(foodRecognition.exceptionOrNull(), isA<ResponseHttpFailure>());
            },
          );
        });

        group('Get data |', () {
          test('Should return recognized food successfully', () async {
            setUpMockCheckConnectionTrue();
            when(() => mockFoodRecognitionDataSourceHttp.getFoodRecognition(any())).thenAnswer(
              (_) async => foodRecognitionDtoExample,
            );
            final foodRecognition = await foodRecognitionRepositoryHttp.getImageRecognition("");
            verify(() => mockFoodRecognitionDataSourceHttp.getFoodRecognition(any())).called(1);
            expect(foodRecognition.isSuccess(), isTrue);
            expect(
              foodRecognition,
              equals(
                Result<KtList<FoodRecognition>, CoreFailure>.success(
                  foodRecognitionDomain.toImmutableList(),
                ),
              ),
            );
          });
        });
      });
    },
  );
}
