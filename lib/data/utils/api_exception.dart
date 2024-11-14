class ApiException implements Exception {
  int? statusCode;
  String? message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() {
    return 'status code is : $statusCode \nmessage is : $message';
  }
}
