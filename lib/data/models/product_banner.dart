class ProductBanner {
  String categoryId;
  String collectionId;
  String id;
  String thumbnail;

  ProductBanner({
    required this.categoryId,
    required this.collectionId,
    required this.id,
    required this.thumbnail,
  });

  factory ProductBanner.fromJson(Map<String, dynamic> json) {
    return ProductBanner(
      categoryId: json['categoryId'],
      collectionId: json['collectionId'],
      id: json['id'],
      thumbnail:
          'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['thumbnail']}',
    );
  }
}
