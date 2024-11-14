import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:dio/dio.dart';

abstract class IAuthentication {
  Future<Response> register(
    String username,
    String password,
    String passwordConfirm,
  );

  Future<String> login(
    String username,
    String password,
  );
}

class Authentication extends IAuthentication {
  final _dio = locator.get<Dio>();

  @override
  Future<Response> register(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      Response response = await _dio.post(
        '/api/collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );

      return response;
    } on DioException catch (ex) {
      throw ApiException(
          ex.response!.statusCode!, ex.response?.data['message']);
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await _dio.post(
        '/api/collections/users/auth-with-password',
        data: {
          'identity': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      }

      return '';
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'There is no error message to show');
    }
  }
}
