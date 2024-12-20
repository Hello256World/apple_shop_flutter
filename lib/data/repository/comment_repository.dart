import 'package:apple_shop_flutter/data/api/comment_api.dart';
import 'package:apple_shop_flutter/data/models/comment.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getProductComments(String productId);
  Future<Either<String, String>> postCommentOfProduct(
      String productId, String comment, String userId);
}

class CommentRepository extends ICommentRepository {
  final ICommentApi _commentApi;

  CommentRepository(this._commentApi);

  @override
  Future<Either<String, List<Comment>>> getProductComments(
      String productId) async {
    try {
      var comments = await _commentApi.fetchProductComment(productId);

      return right(comments);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, String>> postCommentOfProduct(
      String productId, String comment, String userId) async {
    try {
      await _commentApi.postCommentForProduct(productId, comment, userId);
      return right('کامنت برای محصول اضافه شد');
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }
}
