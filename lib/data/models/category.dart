class Category {
  String collectionId;
  String id;
  String title;
  String icon;
  String thumbnail;
  String color;

  Category({
    required this.collectionId,
    required this.id,
    required this.title,
    required this.icon,
    required this.thumbnail,
    required this.color,
  });
//http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME
  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      collectionId: map['collectionId'],
      id: map['id'],
      title: map['title'],
      icon:
          'http://startflutter.ir/api/files/${map['collectionId']}/${map['id']}/${map['icon']}',
      thumbnail:
          'http://startflutter.ir/api/files/${map['collectionId']}/${map['id']}/${map['thumbnail']}',
      color: map['color'],
    );
  }
}
