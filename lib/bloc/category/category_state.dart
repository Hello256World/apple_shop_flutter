import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryState {}

class InitCategoryState extends CategoryState{

}

class FetchCategoryState extends CategoryState{
 final Either<String,List<Category>> categoryList;
  FetchCategoryState(this.categoryList);
}

class CategoryLoadingState extends CategoryState{
}