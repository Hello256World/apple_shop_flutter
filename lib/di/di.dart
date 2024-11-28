import 'package:apple_shop_flutter/bloc/shopping_card/shopping_card_bloc.dart';
import 'package:apple_shop_flutter/data/api/authentication_api.dart';
import 'package:apple_shop_flutter/data/api/banner_api.dart';
import 'package:apple_shop_flutter/data/api/category_api.dart';
import 'package:apple_shop_flutter/data/api/comment_api.dart';
import 'package:apple_shop_flutter/data/api/product_api.dart';
import 'package:apple_shop_flutter/data/models/shopping_card.dart';
import 'package:apple_shop_flutter/data/repository/authentication_repository.dart';
import 'package:apple_shop_flutter/data/repository/banner_repository.dart';
import 'package:apple_shop_flutter/data/repository/category_repository.dart';
import 'package:apple_shop_flutter/data/repository/comment_repository.dart';
import 'package:apple_shop_flutter/data/repository/product_repository.dart';
import 'package:apple_shop_flutter/data/utils/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.I;

Future<void> diSetup() async {
  final dir = await getApplicationDocumentsDirectory();
  locator.registerSingleton<Isar>(
    await Isar.open([ShoppingCardSchema],
        directory: dir.path, name: 'cardInstance'),
  );

  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  locator.registerSingleton<Dio>(DioProvider.createDio());

  // apis
  locator.registerFactory<IAuthentication>(
    () => Authentication(),
  );
  locator.registerFactory<ICategoryApi>(
    () => CategoryApi(locator.get()),
  );
  locator.registerFactory<IBannerApi>(
    () => BannerApi(locator.get()),
  );
  locator.registerFactory<IProductApi>(
    () => ProductApi(locator.get()),
  );
  locator.registerFactory<ICommentApi>(
    () => CommentApi(locator.get()),
  );

  // repositories
  locator.registerFactory<IAuthenticationRepository>(
    () => AuthenticationRepository(locator.get()),
  );
  locator.registerFactory<ICategoryRepository>(
    () => CategoryRepository(locator.get()),
  );
  locator.registerFactory<IBannerRepository>(
    () => BannerRepository(locator.get()),
  );
  locator.registerFactory<IProductRepository>(
    () => ProductRepository(locator.get(), locator.get()),
  );
  locator.registerFactory<ICommentRepository>(
    () => CommentRepository(locator.get()),
  );

  //blocs
  locator.registerSingleton<ShoppingCardBloc>(ShoppingCardBloc(locator.get()));
}
