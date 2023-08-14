import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';
import 'package:flutter_food_recognition/infra/gateway/food_recognition_gateway_http.dart';
import 'package:flutter_food_recognition_core/data_source/data_source_credentials.dart';
import 'package:flutter_food_recognition_core/data_source/data_source_dto.dart';
import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_core/infra/connection/connection.dart';
import 'package:flutter_food_recognition_core/infra/http/http_client.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../flutter_food_recognition_clarifai/test/data/image_recognition_data_example.dart';
import '../../data/food_recognition_domain_example.dart';

class MockConnection extends Mock implements Connection {}

class MockHttpClient extends Mock implements HttpClient {}

class MockDataSourceCredentials extends Mock implements DataSourceCredentials {}

class MockDataSourceDto extends Mock implements DataSourceDto {}

void main() {
  late MockConnection mockConnection;
  late MockHttpClient mockHttpClient;
  late MockDataSourceCredentials mockDataSourceCredentials;
  late MockDataSourceDto mockDataSourceDto;
  late FoodRecognitionGatewayHttp foodRecognitionGatewayHttp;

  setUp(() {
    mockConnection = MockConnection();
    mockHttpClient = MockHttpClient();
    mockDataSourceCredentials = MockDataSourceCredentials();
    mockDataSourceDto = MockDataSourceDto();
    foodRecognitionGatewayHttp = FoodRecognitionGatewayHttp(
      connection: mockConnection,
      httpClient: mockHttpClient,
      dataSourceCredentials: mockDataSourceCredentials,
      dataSourceDto: mockDataSourceDto,
    );
  });

  group(
    'Food Recognition Gateway HTTP |',
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
          final foodRecognition = await foodRecognitionGatewayHttp.getImageRecognition("");
          verify(mockConnection.isConnected).called(1);
          expect(foodRecognition.isError(), isTrue);
          expect(foodRecognition.exceptionOrNull(), isA<CoreFailure>());
          expect(foodRecognition.exceptionOrNull(), isA<ConnectionFailure>());
        });
      });

      group('Is Connected', () {
        void setUpMockDataSourceCredentials() {
          when(() => mockDataSourceCredentials.url).thenReturn('url');
          when(() => mockDataSourceCredentials.headers).thenReturn({'header': 'header'});
          when(() => mockDataSourceCredentials.data(any())).thenReturn({'input': 'input'});
        }

        group('Http Authenticaton Error |', () {
          test(
            'Should return Failure(AuthenticationCredentialsFailure) when some http credentials are missing',
            () async {
              setUpMockCheckConnectionTrue();
              when(() => mockDataSourceCredentials.url).thenThrow(
                const AuthenticationCredentialsException(),
              );
              final foodRecognition = await foodRecognitionGatewayHttp.getImageRecognition("");
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
              setUpMockDataSourceCredentials();
              when(
                () => mockHttpClient.post(
                  url: any(named: 'url'),
                  headers: any(named: 'headers'),
                  data: any(named: 'data'),
                ),
              ).thenThrow(const UnexpectedHttpException());
              final foodRecognition = await foodRecognitionGatewayHttp.getImageRecognition("");
              expect(foodRecognition.isError(), isTrue);
              expect(foodRecognition.exceptionOrNull(), isA<CoreFailure>());
              expect(foodRecognition.exceptionOrNull(), isA<UnexpectedHttpFailure>());
            },
          );

          test(
            'Should return Failure(ResponseHttpFailure) when there is response http exception',
            () async {
              setUpMockCheckConnectionTrue();
              setUpMockDataSourceCredentials();
              when(
                () => mockHttpClient.post(
                  url: any(named: 'url'),
                  headers: any(named: 'headers'),
                  data: any(named: 'data'),
                ),
              ).thenThrow(const ResponseHttpException());
              final foodRecognition = await foodRecognitionGatewayHttp.getImageRecognition('');
              expect(foodRecognition.isError(), isTrue);
              expect(foodRecognition.exceptionOrNull(), isA<CoreFailure>());
              expect(foodRecognition.exceptionOrNull(), isA<ResponseHttpFailure>());
            },
          );
        });

        group('Get data |', () {
          void setUpMockDataSourceDto() {
            when(() => mockDataSourceDto.toFoodRecognitionDomain(any())).thenReturn(
              foodRecognitionDomain,
            );
          }

          test('Should return recognized food successfully', () async {
            setUpMockCheckConnectionTrue();
            setUpMockDataSourceCredentials();
            setUpMockDataSourceDto();
            when(
              () => mockHttpClient.post(
                url: any(named: 'url'),
                headers: any(named: 'headers'),
                data: any(named: 'data'),
              ),
            ).thenAnswer((_) async => imageRecognitionDataResponse);
            final foodRecognition = await foodRecognitionGatewayHttp.getImageRecognition("");
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
            verify(() => mockDataSourceDto.toFoodRecognitionDomain(any())).called(1);
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
