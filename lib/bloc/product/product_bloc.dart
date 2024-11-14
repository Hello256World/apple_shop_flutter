import 'package:apple_shop_flutter/bloc/product/product_event.dart';
import 'package:apple_shop_flutter/bloc/product/product_state.dart';
import 'package:apple_shop_flutter/data/repository/product_repository.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// '5vvww65pv6nviw6'

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductRepository _productRepository = locator.get();
  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>(
      (event, emit) async {
        emit(ProductLoadingState());
        var productImages =
            await _productRepository.getProductImages(event.productId);
        var productVariants =
            await _productRepository.getProductVariants(event.productId);

        var productCategory =
            await _productRepository.getProductCategory(event.categoryId);

        var properties =
            await _productRepository.getProductProperties(event.productId);
        emit(ProductResponseState(
          productImages,
          productVariants,
          productCategory,
          properties,
        ));
      },
    );
  }
}
