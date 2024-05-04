import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/category_repository.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

class CategoryController extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepositoryImpl categoryRepository = CategoryRepositoryImpl();

  CategoryController() : super(const CategoryLoading()) {
    on<LoadCategories>((event, emit) async {
      try {
        final categories = await categoryRepository.getCategories();
        emit(CategoryLoaded(categories));
      } on SocketException {
        emit(const CategoryError("Server bilan bog'lanib bo'lmadi."));
      } catch (e) {
        ADException(e);
        emit(CategoryError(e.toString()));
      }
    });
  }
}

// CategoryEvent represents events that the CategoryBloc can react to
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {
  const LoadCategories();

  @override
  String toString() => 'LoadCategorys';
}

// CategoryState represents the state of the CategoryBloc
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();

  @override
  String toString() => 'CategoryLoading';
}

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
