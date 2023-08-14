import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

import '../../failure/core_exceptions.dart';
import 'http_client.dart';

class UnoAdapter implements HttpClient {
  final Uno uno;

  UnoAdapter({
    required this.uno,
  });

  @override
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await uno.post(
        url,
        headers: headers ?? {},
        data: data,
      );
      if (response.status != 200) {
        throw const ResponseHttpException();
      }

      return response.data;
    } on UnoError {
      throw const UnexpectedHttpException();
    }
  }
}
