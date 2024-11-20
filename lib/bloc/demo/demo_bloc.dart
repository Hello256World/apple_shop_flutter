import 'package:apple_shop_flutter/bloc/demo/demo_event.dart';
import 'package:apple_shop_flutter/bloc/demo/demo_state.dart';
import 'package:apple_shop_flutter/data/repository/product_repository.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  final IProductRepository _productRepository;
  DemoBloc(this._productRepository) : super(InitProductState()) {
    on<ProductResponseEvent>(
      (event, emit) async {
        emit(LoadingProductState());

        var products =
            await _productRepository.getProductsByCategory(event.categoryId);

        emit(ProductResponseState(products));
      },
    );
  }
}
