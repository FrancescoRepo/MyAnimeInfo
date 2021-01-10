import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myanime_info/models/category.dart';
import 'package:myanime_info/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc({@required this.categoryRepository}) : super(FetchingCategoryState());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if(event is FetchCategoryEvent) {
      yield FetchingCategoryState();

      List<Category> categories = await categoryRepository.categories;

      yield FetchedCategoryState(categories: categories);
    }
  }

  void fetchCategories() => add(FetchCategoryEvent());
}
