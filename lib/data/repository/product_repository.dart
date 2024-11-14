import 'package:apple_shop_flutter/data/api/product_api.dart';
import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/models/product.dart';
import 'package:apple_shop_flutter/data/models/product_image.dart';
import 'package:apple_shop_flutter/data/models/product_properties.dart';
import 'package:apple_shop_flutter/data/models/product_variant.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:dartz/dartz.dart';

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
}

class ProductRepository extends IProductRepository {
  final IProductApi _productApi = locator.get();

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
}
