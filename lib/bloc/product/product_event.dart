import 'package:apple_shop_flutter/data/models/product.dart';

abstract class ProductEvent {}


class ProductInitializeEvent extends ProductEvent{
  String productId;
  String categoryId;

  ProductInitializeEvent(this.productId,this.categoryId);
}

class ProductToShopEvent extends ProductEvent{
  Product product;

  ProductToShopEvent(this.product);
}