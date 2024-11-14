class VariantType {
  String id;
  String name;
  String title;
  VariantTypeEnum variantType;

  VariantType(this.id, this.name, this.title, this.variantType);

  factory VariantType.fromJson(Map<String, dynamic> json) {
    return VariantType(
      json['id'],
      json['name'],
      json['title'],
      _setVariantType(json['type']),
    );
  }


}

  VariantTypeEnum _setVariantType(String type) {
    switch (type) {
      case 'Color':
        return VariantTypeEnum.color;
      case 'Storage':
        return VariantTypeEnum.storage;
      case 'Voltage':
        return VariantTypeEnum.voltage;
      default:
        return VariantTypeEnum.color;
    }
  }

enum VariantTypeEnum { color, storage, voltage }
