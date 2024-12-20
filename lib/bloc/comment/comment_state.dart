import 'package:apple_shop_flutter/data/models/comment.dart';
import 'package:dartz/dartz.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResposneState extends CommentState {
  final Either<String, List<Comment>> comments;

  CommentResposneState(this.comments);
}

class AddCommentLoadingState extends CommentState{
  
}

class AddCommentResponseState extends CommentState{
 final Either<String,String> commentResponse;

 AddCommentResponseState(this.commentResponse);
} 