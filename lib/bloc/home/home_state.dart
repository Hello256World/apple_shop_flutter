import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/models/product.dart';
import 'package:apple_shop_flutter/data/models/product_banner.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<ProductBanner>> banners;
  Either<String, List<Category>> categories;
  Either<String, List<Product>> products;
  Either<String, List<Product>> hottestProducts;
  Either<String, List<Product>> bestSellerProducts;

  HomeResponseState({
    required this.banners,
    required this.categories,
    required this.products,
    required this.hottestProducts,
    required this.bestSellerProducts,
  });
}
