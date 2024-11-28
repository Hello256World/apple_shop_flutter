import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:apple_shop_flutter/data/utils/auth_manager.dart';
import 'package:apple_shop_flutter/data/utils/dio_provider.dart';
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
  final Dio _dio = DioProvider.authCreateDio();

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
     await login(username, password);

      return response;
    } on DioException catch (ex) {
      throw ApiException(
          ex.response!.statusCode!, ex.response?.data['message'],response: ex.response);
    } catch (ex) {
      throw ApiException(0, 'there is Error out of Dio Exception');
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
       await AuthManager.saveToken(response.data['token']);
        return response.data['token'];
      }

      return '';
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'There is no error message to show');
    }
  }
}
