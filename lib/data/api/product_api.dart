import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/models/product.dart';
import 'package:apple_shop_flutter/data/models/product_image.dart';
import 'package:apple_shop_flutter/data/models/product_properties.dart';
import 'package:apple_shop_flutter/data/models/product_variant.dart';
import 'package:apple_shop_flutter/data/models/variant.dart';
import 'package:apple_shop_flutter/data/models/variant_type.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductApi {
  Future<List<Product>> fetchProducts();
  Future<List<Product>> fetchHottestProducts();
  Future<List<Product>> fetchBestSellerProducts();
  Future<List<ProductImage>> fetchProductImages(String productId);
  Future<List<VariantType>> fetchVariantTypes();
  Future<List<Variant>> fetchVariants(String productId);
  Future<List<ProductVariant>> fetchProductVariants(String productId);
  Future<Category> fetchProductCategory(String categoryId);
  Future<List<ProductProperties>> fetchProductProperties(String productId);
  Future<List<Product>> fetchProductByCategory(String categoryId);
}

class ProductApi extends IProductApi {
  final Dio _dio;

  ProductApi(this._dio);

  @override
  Future<List<Product>> fetchProducts() async {
    try {
      Response response = await _dio.get('api/collections/products/records');
      List<Product> products = response.data['items']
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      return products;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.message);
    } catch (ex) {
      throw ApiException(0, 'There is error but no message');
    }
  }

  @override
  Future<List<Product>> fetchBestSellerProducts() async {
    Map<String, String> queryParam = {
      'filter': 'popularity="Best Seller"',
    };

    try {
      Response response = await _dio.get(
        'api/collections/products/records',
        queryParameters: queryParam,
      );
      List<Product> products = response.data['items']
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      return products;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.message);
    } catch (ex) {
      throw ApiException(0, 'There is error but no message');
    }
  }

  @override
  Future<List<Product>> fetchHottestProducts() async {
    Map<String, String> queryParam = {
      'filter': 'popularity="Hotest"',
    };

    try {
      Response response = await _dio.get(
        'api/collections/products/records',
        queryParameters: queryParam,
      );
      List<Product> products = response.data['items']
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      return products;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.message);
    } catch (ex) {
      throw ApiException(0, 'There is error but no message');
    }
  }

  @override
  Future<List<ProductImage>> fetchProductImages(String productId) async {
    try {
      Map<String, String> queryParam = {'filter': 'product_id="$productId"'};
      Response response = await _dio.get('api/collections/gallery/records',
          queryParameters: queryParam);
      List<ProductImage> productImages = response.data['items']
          .map<ProductImage>((json) => ProductImage.fromJson(json))
          .toList();
      return productImages;
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'there is Error but not in Dio Exception');
    }
  }

  @override
  Future<List<ProductVariant>> fetchProductVariants(String productId) async {
    try {
      var variants = await fetchVariants(productId);
      var variantTypes = await fetchVariantTypes();

      List<ProductVariant> productVariants = [];

      for (var variantType in variantTypes) {
        var variantsList = variants
            .where(
              (element) => element.typeId == variantType.id,
            )
            .toList();
        productVariants.add(ProductVariant(variantType, variantsList));
      }

      return productVariants;
    } on ApiException catch (ex) {
      throw ApiException(ex.statusCode, ex.message);
    }
  }

  @override
  Future<List<VariantType>> fetchVariantTypes() async {
    try {
      Response response =
          await _dio.get('api/collections/variants_type/records');

      return response.data['items']
          .map<VariantType>((json) => VariantType.fromJson(json))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(
          0, 'there is error out of Dio Exception Variants Type');
    }
  }

  @override
  Future<List<Variant>> fetchVariants(String productId) async {
    try {
      Map<String, String> queryParam = {'filter': 'product_id="$productId"'};
      Response response = await _dio.get('api/collections/variants/records',
          queryParameters: queryParam);

      return response.data['items']
          .map<Variant>((json) => Variant.fromJson(json))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(
          0, 'there is error out of Dio Exception just variants');
    }
  }

  @override
  Future<Category> fetchProductCategory(String categoryId) async {
    try {
      Map<String, String> queryParam = {'filter': 'id="$categoryId"'};
      Response response = await _dio.get('api/collections/category/records',
          queryParameters: queryParam);
      return Category.fromJson(response.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['meesage']);
    } catch (ex) {
      throw ApiException(0, 'Error out of Dio Exception');
    }
  }

  @override
  Future<List<ProductProperties>> fetchProductProperties(
      String productId) async {
    try {
      Map<String, String> queryParam = {'filter': 'product_id="$productId"'};
      var response = await _dio.get(
        'api/collections/properties/records',
        queryParameters: queryParam,
      );

      return response.data['items']
          .map<ProductProperties>((json) => ProductProperties.fromJson(json))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Error Out of Dio Exception');
    }
  }

  @override
  Future<List<Product>> fetchProductByCategory(String categoryId) async {
    try {
      Map<String, String> queryParam = {'filter': 'category="$categoryId"'};
      Response response;
      if (categoryId == 'qnbj8d6b9lzzpn8') {
        response = await _dio.get(
          'api/collections/products/records',
        );
      } else {
        response = await _dio.get('api/collections/products/records',
            queryParameters: queryParam);
      }

      return response.data['items']
          .map<Product>((json) => Product.fromJson(json))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Error Out of Dio Exception');
    }
  }
}
