import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/category_repository.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepositoryImpl categoryRepository = CategoryRepositoryImpl();

  CategoryBloc() : super(CategoryLoading()) {
    on<LoadCategories>((event, emit) async {
      try {
        final categories = await categoryRepository.getCategories();
        emit(CategoryLoaded(categories));
      } on SocketException {
        emit(const CategoryError("Server bilan bog'lanib bo'lmadi."));
      } catch (e) {
        ADException(e);
        emit(CategoryError('CategoryError: $e'));
      }
    });
  }
}
