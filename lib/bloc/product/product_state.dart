import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/models/product_image.dart';
import 'package:apple_shop_flutter/data/models/product_properties.dart';
import 'package:apple_shop_flutter/data/models/product_variant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariants;
  Either<String, Category> productCategory;
  Either<String, List<ProductProperties>> productProperties;

  ProductResponseState(
    this.productImages,
    this.productVariants,
    this.productCategory,
    this.productProperties,
  );
}

class ProducAddedState extends ProductState{
  
}
