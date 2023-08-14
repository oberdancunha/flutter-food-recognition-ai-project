abstract interface class Env {
  String load(String key);
  String get clarifaiBaseUrl;
  String get clarifaiModelUrl;
  String get clarifaiApiModelId;
  String get clarifaiApiModelVersionId;
  String get clarifaiUserId;
  String get clarifaiProjectName;
  String get clarifaiProjectId;
}
