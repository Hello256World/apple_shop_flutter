import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryApi {
  Future<List<Category>> fetchCategories();
}

class CategoryApi extends ICategoryApi {
  final Dio _dio ;

  CategoryApi(this._dio);

  @override
  Future<List<Category>> fetchCategories() async {
    try {
      Response response = await _dio.get('api/collections/category/records');
      List<Category> categories = response.data['items']
          .map<Category>((map) => Category.fromJson(map))
          .toList();

      return categories;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch(ex){
      throw ApiException(0, 'there is error but no message');
    }
  }
}
