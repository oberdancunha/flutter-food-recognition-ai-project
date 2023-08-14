abstract interface class HttpClient {
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  });
}
