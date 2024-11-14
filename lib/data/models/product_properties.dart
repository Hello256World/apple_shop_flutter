class ProductProperties {
  String id;
  String productId;
  String title;
  String value;

  ProductProperties(this.id, this.productId, this.title, this.value);

  factory ProductProperties.fromJson(Map<String, dynamic> json) {
    return ProductProperties(
      json['id'],
      json['product_id'],
      json['title'],
      json['value'],
    );
  }
}
