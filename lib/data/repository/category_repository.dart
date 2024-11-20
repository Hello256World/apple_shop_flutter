import 'package:apple_shop_flutter/data/api/category_api.dart';
import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> fetchCategoryRepository();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryApi _categoryApi;

  CategoryRepository(this._categoryApi);

  @override
  Future<Either<String, List<Category>>> fetchCategoryRepository() async {
    try {
      List<Category> categories = await _categoryApi.fetchCategories();
      return right(categories);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }
}
