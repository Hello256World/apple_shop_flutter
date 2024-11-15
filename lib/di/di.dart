import 'package:apple_shop_flutter/data/api/authentication_api.dart';
import 'package:apple_shop_flutter/data/api/banner_api.dart';
import 'package:apple_shop_flutter/data/api/category_api.dart';
import 'package:apple_shop_flutter/data/api/product_api.dart';
import 'package:apple_shop_flutter/data/repository/authentication_repository.dart';
import 'package:apple_shop_flutter/data/repository/banner_repository.dart';
import 'package:apple_shop_flutter/data/repository/category_repository.dart';
import 'package:apple_shop_flutter/data/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.I;

Future<void> diSetup() async {
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // http://startflutter.ir/
  // https://pocketbase-uicds7.chbk.app/
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'http://startflutter.ir/'),
    ),
  );

  // apis
  locator.registerFactory<IAuthentication>(
    () => Authentication(),
  );
  locator.registerFactory<ICategoryApi>(
    () => CategoryApi(),
  );
  locator.registerFactory<IBannerApi>(
    () => BannerApi(),
  );
  locator.registerFactory<IProductApi>(
    () => ProductApi(),
  );

  // repositories
  locator.registerFactory<IAuthenticationRepository>(
    () => AuthenticationRepository(),
  );
  locator.registerFactory<ICategoryRepository>(
    () => CategoryRepository(),
  );
  locator.registerFactory<IBannerRepository>(
    () => BannerRepository(),
  );
  locator.registerFactory<IProductRepository>(
    () => ProductRepository(),
  );
}
