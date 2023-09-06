import 'package:flutter_food_recognition_clarifai/data_source/clarifai_data_source_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../flutter_food_recognition/test/data/food_recognition_dto_example.dart';
import '../data/image_recognition_data_example.dart';

void main() {
  group('Clarifai Data Source Dto |', () {
    late ClarifaiDataSourceDto clarifaiDataSourceDto;

    setUpAll(() {
      clarifaiDataSourceDto = ClarifaiDataSourceDto();
    });

    group('toFoodRecognitionDomain |', () {
      group('Success |', () {
        test(
          'Should return FoodRecognition domain list when image recognized by clarifai',
          () {
            final foodRecognition =
                clarifaiDataSourceDto.toFoodRecognitionDto(imageRecognitionDataResponse);

            expect(foodRecognition, equals(foodRecognitionDtoExample));
          },
        );
      });

      group('Data not found |', () {
        test(
          'Should return an empty FoodRecognition domain list when the outputs key is not found or is empty.',
          () {
            final input = {
              "outputs": [],
            };
            final foodRecognition = clarifaiDataSourceDto.toFoodRecognitionDto(input);
            expect(foodRecognition.length, isZero);
            expect(foodRecognition, equals([]));
          },
        );

        test(
          'Should return an empty FoodRecognition domain list when the data key is not found or is empty.',
          () {
            final input = {
              "outputs": [
                {
                  "data": {},
                },
              ],
            };
            final foodRecognition = clarifaiDataSourceDto.toFoodRecognitionDto(input);
            expect(foodRecognition.length, isZero);
            expect(foodRecognition, equals([]));
          },
        );

        test(
          'Should return an empty FoodRecognition domain list when the concepts key is not found or is empty.',
          () {
            final input = {
              "outputs": [
                {
                  "data": {
                    "concepts": [],
                  },
                },
              ],
            };
            final foodRecognition = clarifaiDataSourceDto.toFoodRecognitionDto(input);
            expect(foodRecognition.length, isZero);
            expect(foodRecognition, equals([]));
          },
        );

        test(
          'Should return an empty FoodRecognition domain list when the image recognized by clarifai contains inconsistent data.',
          () {
            final input = {
              "outputs": [
                {
                  "data": {
                    "concepts": [
                      {"id": "ai_3PlgVmlN", "name": "", "value": 0.9863696, "app_id": "main"},
                      {"id": "ai_s9XQJtDb", "name": "dinner", "value": 0.0, "app_id": "main"},
                    ],
                  },
                },
              ],
            };
            final foodRecognition = clarifaiDataSourceDto.toFoodRecognitionDto(input);
            expect(foodRecognition.length, isZero);
            expect(foodRecognition, equals([]));
          },
        );
      });
    });
  });
}
