import 'package:apple_shop_flutter/bloc/category/category_event.dart';
import 'package:apple_shop_flutter/bloc/category/category_state.dart';
import 'package:apple_shop_flutter/data/repository/category_repository.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepo = locator.get();
  CategoryBloc() : super(InitCategoryState()) {
    on<FetchCategories>(
      (event, emit) async {
        emit(CategoryLoadingState());
        var either = await _categoryRepo.fetchCategoryRepository();
        emit(FetchCategoryState(either));
      },
    );
  }
}
