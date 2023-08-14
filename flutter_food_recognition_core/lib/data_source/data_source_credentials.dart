abstract interface class DataSourceCredentials {
  String get url;
  Map<String, String>? get headers;
  Map<String, dynamic> data(String input);
}
