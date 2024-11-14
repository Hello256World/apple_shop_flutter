class Variant {
  String id;
  String name;
  String typeId;
  String value;
  int priceChange;

  Variant(this.id, this.name, this.typeId, this.value, this.priceChange);

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      json['id'],
      json['name'],
      json['type_id'],
      json['value'],
      json['price_change'],
    );
  }
}
