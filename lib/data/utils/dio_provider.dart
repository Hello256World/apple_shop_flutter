import 'package:apple_shop_flutter/data/utils/auth_manager.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDio() {
    return Dio(BaseOptions(baseUrl: 'http://startflutter.ir/', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AuthManager.readAuth()},'
    }));
  }

  static Dio authCreateDio() {
    return Dio(BaseOptions(baseUrl: 'https://pocketbase-uicds7.chbk.app/'));
  }
}
