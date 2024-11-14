import 'package:apple_shop_flutter/data/models/product.dart';
import 'package:dartz/dartz.dart';

abstract class DemoState {}

class InitProductState extends DemoState{}

class LoadingProductState extends DemoState{}

class ProductResponseState extends DemoState{

  Either<String,List<Product>> products;

  ProductResponseState(this.products);

}