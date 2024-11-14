import 'package:apple_shop_flutter/data/api/banner_api.dart';
import 'package:apple_shop_flutter/data/models/product_banner.dart';
import 'package:apple_shop_flutter/data/utils/api_exception.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<String, List<ProductBanner>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerApi _bannerApi = locator.get();
  
  @override
  Future<Either<String, List<ProductBanner>>> getBanners() async {
    try {
      var banners = await _bannerApi.fetchProductBanners();
      return right(banners);
    } on ApiException catch (ex) {
      return left(ex.toString());
    }
  }
}
