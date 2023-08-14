import 'package:flutter_food_recognition_core/data_source/data_source_credentials.dart';

import '../infra/env/env.dart';

class ClarifaiCredentials implements DataSourceCredentials {
  late final Env _env;

  ClarifaiCredentials({required Env env}) {
    _env = env;
  }

  @override
  Map<String, dynamic> data(String input) => {
        "user_app_id": {
          "user_id": _env.clarifaiUserId,
          "app_id": _env.clarifaiProjectName,
        },
        "inputs": [
          {
            "data": {
              "image": {
                "base64": input,
              }
            }
          }
        ]
      };

  @override
  Map<String, String> get headers => {
        'Accept': 'application/json',
        'Authorization': 'Key ${_env.clarifaiProjectId}',
      };

  @override
  String get url =>
      '${_env.clarifaiBaseUrl}/${_env.clarifaiModelUrl}/${_env.clarifaiApiModelId}/${_env.clarifaiApiModelVersionId}/outputs';
}
