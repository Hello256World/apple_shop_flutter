abstract class CommentEvent {}

class CommentResposneEvent extends CommentEvent {
  String productId;

  CommentResposneEvent(this.productId);
}

class AddCommentEvent extends CommentEvent {
  final String comment;
  final String userId;
  final String productId;
  AddCommentEvent(this.comment,this.productId,this.userId);
}
