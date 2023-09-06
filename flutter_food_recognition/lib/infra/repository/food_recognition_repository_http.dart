import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_core/infra/connection/connection.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../../data_source/food_recognition_data_source_http.dart';
import '../../domain/entities/food_recognition.dart';
import 'food_recognition_repository.dart';

class FoodRecognitionRepositoryHttp implements FoodRecognitionRepository {
  late final Connection _connection;
  late final FoodRecognitionDataSourceHttp _foodRecognitionDataSourceHttp;

  FoodRecognitionRepositoryHttp({
    required Connection connection,
    required FoodRecognitionDataSourceHttp foodRecognitionDataSourceHttp,
  })  : _connection = connection,
        _foodRecognitionDataSourceHttp = foodRecognitionDataSourceHttp;

  @override
  Future<Result<KtList<FoodRecognition>, CoreFailure>> getImageRecognition(
    String base64Image,
  ) async {
    if (await _connection.isConnected()) {
      try {
        final foodRecognitionDtoList = await _foodRecognitionDataSourceHttp.getFoodRecognition(
          base64Image,
        );
        final foodRecognition = foodRecognitionDtoList
            .map(
              (foodRecognitionDto) => foodRecognitionDto.toDomain(),
            )
            .toList();

        return Result.success(foodRecognition.toImmutableList());
      } on AuthenticationCredentialsException catch (_) {
        return Result.failure(const AuthenticationCredentialsFailure());
      } on UnexpectedHttpException catch (_) {
        return Result.failure(const UnexpectedHttpFailure());
      } on ResponseHttpException catch (_) {
        return Result.failure(const ResponseHttpFailure());
      }
    } else {
      return Result.failure(const ConnectionFailure());
    }
  }
}
