class Product {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discountPrice;
  int price;
  String popularity;
  String name;
  int quantity;
  String categoryId;

  Product(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.description,
    this.discountPrice,
    this.price,
    this.popularity,
    this.name,
    this.quantity,
    this.categoryId,
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['collectionId'],
      'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['thumbnail']}',
      json['description'],
      json['discount_price'],
      json['price'],
      json['popularity'],
      json['name'],
      json['quantity'],
      json['category'],
    );
  }
}
