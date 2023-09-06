import 'dart:io';

import 'package:flutter_food_recognition_clarifai/infra/env/dotenv_adapter.dart';
import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DotEnv Adapter |', () {
    group('Mock |', () {
      late DotEnv env;
      late DotEnvAdapter dotEnvAdapter;

      group('Success |', () {
        setUpAll(() {
          env = DotEnv()..testLoad(fileInput: File('test/data/.test_env').readAsStringSync());
          dotEnvAdapter = DotEnvAdapter(env: env);
        });

        test('Should return CLARIFAI_BASE_URL', () {
          expect(dotEnvAdapter.clarifaiBaseUrl, equals('https://api.clarifai.com'));
        });

        test('Should return CLARIFAI_MODEL_URL', () {
          expect(dotEnvAdapter.clarifaiModelUrl, 'v2/models');
        });

        test('Should return CLARIFAI_API_MODEL_ID', () {
          expect(dotEnvAdapter.clarifaiApiModelId, 'general-image-recognition/versions');
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
          env = DotEnv()..testLoad(fileInput: File('test/data/.test_error_env').readAsStringSync());
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

    group('File |', () {
      late DotEnvAdapter dotEnvAdapter;

      setUpAll(() {
        dotEnvAdapter = DotEnvAdapter(fileName: '.env');
      });

      test('Should return CLARIFAI_BASE_URL', () {
        expect(dotEnvAdapter.clarifaiBaseUrl, equals('https://api.clarifai.com'));
      });

      test('Should return CLARIFAI_MODEL_URL', () {
        expect(dotEnvAdapter.clarifaiModelUrl, 'v2/models');
      });

      test('Should return CLARIFAI_API_MODEL_ID', () {
        expect(dotEnvAdapter.clarifaiApiModelId, 'general-image-recognition/versions');
      });
    });
  });
}
