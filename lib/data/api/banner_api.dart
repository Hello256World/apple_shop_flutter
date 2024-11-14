import 'package:apple_shop_flutter/data/models/product_banner.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:dio/dio.dart';

abstract class IBannerApi {
  Future<List<ProductBanner>> fetchProductBanners();
}

class BannerApi extends IBannerApi {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductBanner>> fetchProductBanners() async {
    try {
      Response response = await _dio.get('api/collections/banner/records');
      List<ProductBanner> bannersList = response.data['items']
          .map<ProductBanner>((json) => ProductBanner.fromJson(json))
          .toList();
      return bannersList;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Error has no text');
    }
  }
}
