class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userThumbnail;
  String username;

  Comment(
    this.id,
    this.text,
    this.productId,
    this.userId,
    this.userThumbnail,
    this.username,
  );

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json['id'],
      json['text'],
      json['product_id'],
      json['user_id'],
      'http://startflutter.ir/api/files/${json['expand']['user_id']['collectionName']}/${json['expand']['user_id']['id']}/${json['expand']['user_id']['avatar']}',
      json['expand']['user_id']['name'],
    );
  }
}
