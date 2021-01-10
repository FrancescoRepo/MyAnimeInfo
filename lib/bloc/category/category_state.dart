part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class FetchingCategoryState extends CategoryState {
  @override
  List<Object> get props => [];
}

class FetchedCategoryState extends CategoryState {
  final List<Category> categories;

  FetchedCategoryState({@required this.categories});

  @override
  List<Object> get props => [categories];
}
