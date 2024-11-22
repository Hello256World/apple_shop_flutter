abstract class CommentEvent {}

class CommentResposneEvent extends CommentEvent {
  String productId;

  CommentResposneEvent(this.productId);
}