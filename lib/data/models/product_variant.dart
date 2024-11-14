import 'package:apple_shop_flutter/data/models/variant.dart';
import 'package:apple_shop_flutter/data/models/variant_type.dart';

class ProductVariant {
  VariantType variantType;
  List<Variant> variants;

  ProductVariant(this.variantType,this.variants);
}