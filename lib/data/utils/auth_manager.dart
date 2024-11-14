import 'package:apple_shop_flutter/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier valueNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static Future<void> saveToken(String token) async {
    await _sharedPref.setString('access_token', token);
    valueNotifier.value = 'loggedIn';
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static Future<void> logOut() async {
    await _sharedPref.remove('access_token');
    valueNotifier.value = 'logged Out';
  }

  static bool isLogin() {
    var token = readAuth();
    valueNotifier.value = token.isNotEmpty;
    return token.isNotEmpty;
  }
}
