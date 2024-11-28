import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? statusCode;
  String? message;
  Response<dynamic>? response;

  ApiException(this.statusCode, this.message, {this.response}) {
    if (message == null) {
      return;
    }
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است';
    }
    if (response?.data['data']['username'] != null &&
        response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
      message = 'نام کاربری نامعتبر یا تکراری می باشد';
    }
  }

  @override
  String toString() {
    return 'status code is : $statusCode \nmessage is : $message';
  }
}
