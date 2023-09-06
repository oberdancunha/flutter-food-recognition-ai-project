import 'package:flutter_food_recognition/data_source/food_recognition_data_source_http.dart';
import 'package:flutter_food_recognition_core/data_source/data_source_credentials.dart';
import 'package:flutter_food_recognition_core/data_source/data_source_dto.dart';
import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_core/infra/http/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../flutter_food_recognition_clarifai/test/data/image_recognition_data_example.dart';
import '../data/food_recognition_dto_example.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockDataSourceCredentials extends Mock implements DataSourceCredentials {}

class MockDataSourceDto extends Mock implements DataSourceDto {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockDataSourceCredentials mockDataSourceCredentials;
  late MockDataSourceDto mockDataSourceDto;
  late FoodRecognitionDataSourceHttp foodRecognitionDataSourceHttp;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockDataSourceCredentials = MockDataSourceCredentials();
    mockDataSourceDto = MockDataSourceDto();
    foodRecognitionDataSourceHttp = FoodRecognitionDataSourceHttp(
      httpClient: mockHttpClient,
      dataSourceCredentials: mockDataSourceCredentials,
      dataSourceDto: mockDataSourceDto,
    );
  });

  group('Food Recognition Data Source HTTP |', () {
    void setUpMockDataSourceCredentials() {
      when(() => mockDataSourceCredentials.url).thenReturn('url');
      when(() => mockDataSourceCredentials.headers).thenReturn({'header': 'header'});
      when(() => mockDataSourceCredentials.data(any())).thenReturn({'input': 'input'});
    }

    group('getFoodRecognition |', () {
      group('Http Authenticaton Error |', () {
        test(
          'Should throw an AuthenticationCredentialsException when some http credentials are missing',
          () async {
            when(() => mockDataSourceCredentials.url).thenThrow(
              const AuthenticationCredentialsException(),
            );
            final getFoodRecognitionCall = foodRecognitionDataSourceHttp.getFoodRecognition;
            expect(
              () async => getFoodRecognitionCall(""),
              throwsA(const TypeMatcher<AuthenticationCredentialsException>()),
            );
          },
        );
      });

      group('Http Error |', () {
        test(
          'Should throw an UnexpectedHttpException when there is an unexpected http exception',
          () async {
            setUpMockDataSourceCredentials();
            when(
              () => mockHttpClient.post(
                url: any(named: 'url'),
                headers: any(named: 'headers'),
                data: any(named: 'data'),
              ),
            ).thenThrow(const UnexpectedHttpException());
            final getFoodRecognitionCall = foodRecognitionDataSourceHttp.getFoodRecognition;
            expect(
              () async => getFoodRecognitionCall(""),
              throwsA(const TypeMatcher<UnexpectedHttpException>()),
            );
          },
        );

        test(
          'Should throw a ResponseHttpException when there is response http exception',
          () async {
            setUpMockDataSourceCredentials();
            when(
              () => mockHttpClient.post(
                url: any(named: 'url'),
                headers: any(named: 'headers'),
                data: any(named: 'data'),
              ),
            ).thenThrow(const ResponseHttpException());
            final getFoodRecognitionCall = foodRecognitionDataSourceHttp.getFoodRecognition;
            expect(
              () async => getFoodRecognitionCall(""),
              throwsA(const TypeMatcher<ResponseHttpException>()),
            );
          },
        );
      });

      group('Get data |', () {
        test('Should return recognized food dto successfully', () async {
          setUpMockDataSourceCredentials();
          when(
            () => mockHttpClient.post(
              url: any(named: 'url'),
              headers: any(named: 'headers'),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async => imageRecognitionDataResponse);
          when(() => mockDataSourceDto.toFoodRecognitionDto(any())).thenReturn(
            foodRecognitionDtoExample,
          );
          final foodRecognitionDto = await foodRecognitionDataSourceHttp.getFoodRecognition("");
          verify(() => mockDataSourceCredentials.url).called(1);
          verify(() => mockDataSourceCredentials.headers).called(1);
          verify(() => mockDataSourceCredentials.data(any())).called(1);
          verify(
            () => mockHttpClient.post(
              url: any(named: 'url'),
              headers: any(named: 'headers'),
              data: any(named: 'data'),
            ),
          ).called(1);
          verify(() => mockDataSourceDto.toFoodRecognitionDto(any())).called(1);
          expect(foodRecognitionDto, equals(foodRecognitionDtoExample));
        });
      });
    });
  });
}
