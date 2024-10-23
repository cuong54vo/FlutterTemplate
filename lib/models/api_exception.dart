class APIException implements Exception {
  String error;
  APIException({required this.error});
}
