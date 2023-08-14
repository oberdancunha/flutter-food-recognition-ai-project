import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_core/infra/http/uno_adapter.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUno extends Mock implements Uno {}

void main() {
  late MockUno mockUno;
  late UnoAdapter unoAdapter;
  late Map<String, String> headers;
  late Map<String, String> data;

  setUpAll(() {
    mockUno = MockUno();
    unoAdapter = UnoAdapter(
      uno: mockUno,
    );
    headers = {'headers': 'testuno'};
    data = {"test": "uno", "method": "post"};
  });

  group('Uno Adapter |', () {
    group('Post |', () {
      test('Should return a post request successfully.', () async {
        when(
          () => mockUno.post(
            any(),
            headers: any(named: 'headers'),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            headers: headers,
            request: Request(
              uri: Uri.parse('https://api.com'),
              method: 'post',
              headers: headers,
              timeout: const Duration(milliseconds: 300),
            ),
            status: 200,
            data: data,
          ),
        );
        final responseData = await unoAdapter.post(
          url: '/',
          headers: headers,
          data: {"test": "uno"},
        );
        expect(responseData, equals(data));
      });

      group('Errors |', () {
        test('Should throw a UnexpectedHttpException when there is a unexpected error', () {
          when(
            () => mockUno.post(
              any(),
              headers: any(named: 'headers'),
              data: any(named: 'data'),
            ),
          ).thenThrow(const UnoError(""));
          final callPost = unoAdapter.post;
          expect(
            () async => callPost(
              url: '/',
              headers: headers,
              data: {"test": "uno"},
            ),
            throwsA(const TypeMatcher<UnexpectedHttpException>()),
          );
        });

        test('Should throw a ResponseHttpException when response status is not equal to 200', () {
          when(
            () => mockUno.post(
              any(),
              headers: any(named: 'headers'),
              data: any(named: 'data'),
            ),
          ).thenAnswer(
            (_) async => Response(
              headers: headers,
              request: Request(
                uri: Uri.parse('https://api.com'),
                method: 'post',
                headers: headers,
                timeout: const Duration(milliseconds: 300),
              ),
              status: 400,
              data: {},
            ),
          );
          final callPost = unoAdapter.post;
          expect(
            () async => callPost(
              url: '/',
              headers: headers,
              data: {"test": "uno"},
            ),
            throwsA(const TypeMatcher<ResponseHttpException>()),
          );
        });
      });
    });
  });
}
