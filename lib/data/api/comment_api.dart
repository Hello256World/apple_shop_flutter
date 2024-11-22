import 'package:apple_shop_flutter/data/models/comment.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICommentApi {
  Future<List<Comment>> fetchProductComment(String productId);
}

class CommentApi extends ICommentApi {
  final Dio _dio;

  CommentApi(this._dio);

  @override
  Future<List<Comment>> fetchProductComment(String productId) async {
    try {
      Map<String, String> queryParam = {
        'filter': 'product_id="$productId"',
        'expand': 'user_id',
      };
      Response response = await _dio.get(
        'api/collections/comment/records',
        queryParameters: queryParam,
      );
      List<Comment> commentList = response.data['items']
          .map<Comment>((json) => Comment.fromJson(json))
          .toList();
      return commentList;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'error is out of Dio Exception');
    }
  }
}
