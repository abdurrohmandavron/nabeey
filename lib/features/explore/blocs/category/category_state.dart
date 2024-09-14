import 'package:equatable/equatable.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'CategoryLoaded { Categorys: $categories }';
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'CategoryError { message: $message }';
}

class CategoryEmpty extends CategoryState {
  final String message;

  const CategoryEmpty(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'CategoryEmpty { message: $message }';
}
