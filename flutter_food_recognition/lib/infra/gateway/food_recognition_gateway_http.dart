import 'package:flutter_food_recognition_core/data_source/data_source_credentials.dart';
import 'package:flutter_food_recognition_core/data_source/data_source_dto.dart';
import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_core/infra/connection/connection.dart';
import 'package:flutter_food_recognition_core/infra/http/http_client.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../../domain/entities/food_recognition.dart';
import 'food_recognition_gateway.dart';

class FoodRecognitionGatewayHttp implements FoodRecognitionGateway {
  late final Connection _connection;
  late final HttpClient _httpClient;
  late final DataSourceCredentials _dataSourceCredentials;
  late final DataSourceDto _dataSourceDto;

  FoodRecognitionGatewayHttp({
    required Connection connection,
    required HttpClient httpClient,
    required DataSourceCredentials dataSourceCredentials,
    required DataSourceDto dataSourceDto,
  }) {
    _connection = connection;
    _httpClient = httpClient;
    _dataSourceCredentials = dataSourceCredentials;
    _dataSourceDto = dataSourceDto;
  }

  @override
  Future<Result<KtList<FoodRecognition>, CoreFailure>> getImageRecognition(
    String base64Image,
  ) async {
    if (await _connection.isConnected()) {
      try {
        final foodRecognitionResponse = await _httpClient.post(
          url: _dataSourceCredentials.url,
          headers: _dataSourceCredentials.headers ?? {},
          data: _dataSourceCredentials.data(base64Image),
        );
        final foodRecognition = _dataSourceDto.toFoodRecognitionDomain(
          foodRecognitionResponse as Map<String, dynamic>,
        );
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
