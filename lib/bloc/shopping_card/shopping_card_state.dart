import 'package:apple_shop_flutter/data/models/shopping_card.dart';
import 'package:dartz/dartz.dart';

abstract class ShoppingCardState {}

class ShoppingCardInitState extends ShoppingCardState{}

class ShoppingCardDataState extends ShoppingCardState{
  Either<String,List<ShoppingCard>> cards;

  ShoppingCardDataState(this.cards);
}