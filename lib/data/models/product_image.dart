class ProductImage {
  String imageUrl;
  String productId;

  ProductImage(this.imageUrl, this.productId);

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['image']}',
      json['product_id'],
    );
  }
}
