import 'package:flutter_food_recognition_core/failure/core_exceptions.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import 'env.dart';

class DotEnvAdapter implements Env {
  late DotEnv? _env;

  DotEnvAdapter({DotEnv? env}) {
    _env = env;
    _init();
  }

  Future<void> _init() async {
    if (_env == null) {
      _env = DotEnv();
      await _env!.load();
    } else if (!_env!.isInitialized) {
      _env!.load();
    }
  }

  @override
  String get clarifaiApiModelId => load('CLARIFAI_API_MODEL_ID');

  @override
  String get clarifaiApiModelVersionId => load('CLARIFAI_API_MODEL_VERSION_ID');

  @override
  String get clarifaiBaseUrl => load('CLARIFAI_BASE_URL');

  @override
  String get clarifaiModelUrl => load('CLARIFAI_MODEL_URL');

  @override
  String get clarifaiProjectId => load('CLARIFAI_PROJECT_ID');

  @override
  String get clarifaiProjectName => load('CLARIFAI_PROJECT_NAME');

  @override
  String get clarifaiUserId => load('CLARIFAI_USER_ID');

  @override
  String load(String key) {
    final value = _env!.maybeGet(key);
    if (value != null && value.isNotEmpty && value != "''") {
      return value;
    }

    throw const AuthenticationCredentialsException();
  }
}
