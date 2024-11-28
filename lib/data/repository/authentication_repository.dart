import 'package:apple_shop_flutter/data/api/authentication_api.dart';
import 'package:apple_shop_flutter/data/utils/auth_manager.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> registerRepository(
    String username,
    String password,
    String passwordConfirm,
  );

  Future<Either<String, String>> loginRepository(
    String username,
    String password,
  );
}

class AuthenticationRepository extends IAuthenticationRepository {
  final IAuthentication _authenticatoin;

  AuthenticationRepository(this._authenticatoin);

  @override
  Future<Either<String, String>> registerRepository(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _authenticatoin.register(username, password, passwordConfirm);

      return const Right('ثبت نام انجام شد');
    } on ApiException catch (e) {
      return left(e.message!);
    }
  }

  @override
  Future<Either<String, String>> loginRepository(
    String username,
    String password,
  ) async {
    try {
      var token = await _authenticatoin.login(username, password);
      if (token.isNotEmpty) {
        await AuthManager.saveToken(token);

        return right('شما وارد شده اید');
      }
      return right('there is no error and token');
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
