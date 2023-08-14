import 'package:flutter_food_recognition_clarifai/infra/env/dotenv_adapter.dart';
import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DotEnv env;
  late DotEnvAdapter dotEnvAdapter;

  group('DotEnv Adapter |', () {
    group('Success |', () {
      setUpAll(() {
        env = DotEnv()
          ..addAll(
            {
              'CLARIFAI_BASE_URL': 'https://api.clarifai.com',
              'CLARIFAI_MODEL_URL': '/v2/models/',
              'CLARIFAI_API_MODEL_ID': 'general-image-recognition',
              'CLARIFAI_API_MODEL_VERSION_ID': 'dxx1heshob9av97z4nb3azitgqb0stx6',
              'CLARIFAI_USER_ID': 'useridclarifai',
              'CLARIFAI_PROJECT_NAME': 'projectnameclarifai',
              'CLARIFAI_PROJECT_ID': 'q9zactk21d6fr7meqokfkvb4va0cxdox',
            },
          );
        dotEnvAdapter = DotEnvAdapter(env: env);
      });

      test('Should return CLARIFAI_BASE_URL', () {
        expect(dotEnvAdapter.clarifaiBaseUrl, equals('https://api.clarifai.com'));
      });

      test('Should return CLARIFAI_MODEL_URL', () {
        expect(dotEnvAdapter.clarifaiModelUrl, '/v2/models/');
      });

      test('Should return CLARIFAI_API_MODEL_ID', () {
        expect(dotEnvAdapter.clarifaiApiModelId, 'general-image-recognition');
      });

      test('Should return CLARIFAI_API_MODEL_VERSION_ID', () {
        expect(dotEnvAdapter.clarifaiApiModelVersionId, 'dxx1heshob9av97z4nb3azitgqb0stx6');
      });

      test('Should return CLARIFAI_USER_ID', () {
        expect(dotEnvAdapter.clarifaiUserId, 'useridclarifai');
      });

      test('Should return CLARIFAI_PROJECT_NAME', () {
        expect(dotEnvAdapter.clarifaiProjectName, 'projectnameclarifai');
      });

      test('Should return CLARIFAI_PROJECT_ID', () {
        expect(dotEnvAdapter.clarifaiProjectId, 'q9zactk21d6fr7meqokfkvb4va0cxdox');
      });
    });

    group('Exception |', () {
      setUpAll(() {
        env = DotEnv()
          ..addAll(
            {
              'CLARIFAI_BASE_URL': 'https://api.clarifai.com',
              'CLARIFAI_MODEL_URL': '/v2/models/',
              'CLARIFAI_API_MODEL_ID': 'general-image-recognition',
              'CLARIFAI_API_MODEL_VERSION_ID': 'dxx1heshob9av97z4nb3azitgqb0stx6',
              'CLARIFAI_PROJECT_NAME': '',
              'CLARIFAI_PROJECT_ID': 'q9zactk21d6fr7meqokfkvb4va0cxdox',
            },
          );
        dotEnvAdapter = DotEnvAdapter(env: env);
      });

      test(
        'Should throw an AuthenticationCredentialsException when there are missing authentication credentials (CLARIFAI_USER_ID for example)',
        () {
          expect(
            () => dotEnvAdapter.clarifaiUserId,
            throwsA(const TypeMatcher<AuthenticationCredentialsException>()),
          );
        },
      );

      test(
        'Should throw an AuthenticationCredentialsException when there are empty authentication credentials (CLARIFAI_PROJECT_NAME for example)',
        () {
          expect(
            () => dotEnvAdapter.clarifaiProjectName,
            throwsA(const TypeMatcher<AuthenticationCredentialsException>()),
          );
        },
      );
    });
  });
}
