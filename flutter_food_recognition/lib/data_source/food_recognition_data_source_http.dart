import 'package:flutter_food_recognition_core/data_source/data_source_credentials.dart';
import 'package:flutter_food_recognition_core/data_source/data_source_dto.dart';
import 'package:flutter_food_recognition_core/infra/http/http_client.dart';

import '../infra/repository/food_recognition_dto.dart';

class FoodRecognitionDataSourceHttp {
  final HttpClient _httpClient;
  final DataSourceCredentials _dataSourceCredentials;
  final DataSourceDto _dataSourceDto;

  FoodRecognitionDataSourceHttp({
    required HttpClient httpClient,
    required DataSourceCredentials dataSourceCredentials,
    required DataSourceDto dataSourceDto,
  })  : _httpClient = httpClient,
        _dataSourceCredentials = dataSourceCredentials,
        _dataSourceDto = dataSourceDto;

  Future<List<FoodRecognitionDto>> getFoodRecognition(String base64Image) async {
    final foodRecognitionResponse = await _httpClient.post(
      url: _dataSourceCredentials.url,
      headers: _dataSourceCredentials.headers ?? {},
      data: _dataSourceCredentials.data(base64Image),
    );

    return _dataSourceDto.toFoodRecognitionDto(foodRecognitionResponse as Map<String, dynamic>);
  }
}
