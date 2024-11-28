import 'package:apple_shop_flutter/bloc/shopping_card/shopping_card_event.dart';
import 'package:apple_shop_flutter/bloc/shopping_card/shopping_card_state.dart';
import 'package:apple_shop_flutter/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCardBloc extends Bloc<ShoppingCardEvent, ShoppingCardState> {
  final IProductRepository _productRepository;
  ShoppingCardBloc(this._productRepository) : super(ShoppingCardInitState()) {
    on<ShoppingCardDataEvent>(
      (event, emit) async {
        var cards = await _productRepository.getShoppingCardItems();

        emit(ShoppingCardDataState(cards));
      },
    );

    on<ShoppingCardProductRemoveEvent>(
      (event, emit) async {
        await _productRepository.removeProductFromShop(event.productId);
        var cards = await _productRepository.getShoppingCardItems();
        emit(ShoppingCardDataState(cards));
      },
    );
  }
}
