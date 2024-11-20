import 'package:apple_shop_flutter/bloc/home/home_event.dart';
import 'package:apple_shop_flutter/bloc/home/home_state.dart';
import 'package:apple_shop_flutter/data/repository/banner_repository.dart';
import 'package:apple_shop_flutter/data/repository/category_repository.dart';
import 'package:apple_shop_flutter/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository;
  final ICategoryRepository _categoryRepository;
  final IProductRepository _productRepository;

  HomeBloc(
    this._bannerRepository,
    this._categoryRepository,
    this._productRepository,
  ) : super(HomeInitState()) {
    on<HomeResponseEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        var banners = await _bannerRepository.getBanners();
        var categories = await _categoryRepository.fetchCategoryRepository();
        var products = await _productRepository.getProducts();
        var hottestProducts = await _productRepository.getHottestProducts();
        var bestSellerProducts =
            await _productRepository.getBestSellerProducts();
        emit(HomeResponseState(
          banners: banners,
          categories: categories,
          products: products,
          hottestProducts: hottestProducts,
          bestSellerProducts: bestSellerProducts,
        ));
      },
    );
  }
}
