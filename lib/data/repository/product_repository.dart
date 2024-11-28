import 'dart:async';
import 'package:apple_shop_flutter/data/api/product_api.dart';
import 'package:apple_shop_flutter/data/models/shopping_card.dart';
import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/models/product.dart';
import 'package:apple_shop_flutter/data/models/product_image.dart';
import 'package:apple_shop_flutter/data/models/product_properties.dart';
import 'package:apple_shop_flutter/data/models/product_variant.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getHottestProducts();
  Future<Either<String, List<Product>>> getBestSellerProducts();
  Future<Either<String, List<ProductImage>>> getProductImages(String productId);
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);
  Future<Either<String, Category>> getProductCategory(String categoryId);
  Future<Either<String, List<ProductProperties>>> getProductProperties(
      String productId);
  Future<Either<String, List<Product>>> getProductsByCategory(
      String categoryId);
  Future<Either<String, String>> addProductToShop(Product product);
  Future<Either<String, List<ShoppingCard>>> getShoppingCardItems();
  Future<void> removeProductFromShop(int productId);
}

class ProductRepository extends IProductRepository {
  final IProductApi _productApi;
  final Isar _dbInstance;

  ProductRepository(this._productApi, this._dbInstance);

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      List<Product> products = await _productApi.fetchProducts();
      return right(products);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSellerProducts() async {
    try {
      var bestSellerProducts = await _productApi.fetchBestSellerProducts();
      return right(bestSellerProducts);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> getHottestProducts() async {
    try {
      var bestSellerProducts = await _productApi.fetchHottestProducts();
      return right(bestSellerProducts);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<ProductImage>>> getProductImages(
    String productId,
  ) async {
    try {
      List<ProductImage> productImage =
          await _productApi.fetchProductImages(productId);
      return right(productImage);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      var productVariants = await _productApi.fetchProductVariants(productId);
      return right(productVariants);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      var category = await _productApi.fetchProductCategory(categoryId);
      return right(category);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<ProductProperties>>> getProductProperties(
      String productId) async {
    try {
      var propeties = await _productApi.fetchProductProperties(productId);
      return right(propeties);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> getProductsByCategory(
      String categoryId) async {
    try {
      var products = await _productApi.fetchProductByCategory(categoryId);
      return right(products);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, String>> addProductToShop(Product product) async {
    try {
      var card = ShoppingCard()
        ..name = product.name
        ..categoryId = product.categoryId
        ..collectionId = product.collectionId
        ..discountPrice = product.discountPrice
        ..price = product.price
        ..productId = product.id
        ..thumbnail = product.thumbnail;

      await _dbInstance.writeTxn(() async {
        await _dbInstance.shoppingCards.put(card);
      });

      return right('product added to shopping card');
    } catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<ShoppingCard>>> getShoppingCardItems() async {
    try {
      await Future.delayed(const Duration(milliseconds: 50));
      var cards = await _dbInstance.shoppingCards.where().findAll();

      return right(cards);
    } catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<void> removeProductFromShop(int productId) async {
    await _dbInstance.writeTxn(() async {
      await _dbInstance.shoppingCards.delete(productId);
    });
  }
}
