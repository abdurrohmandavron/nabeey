import '../base/base_bloc.dart';
import '../../../../data/repositories/category_repository.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends BaseBloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryLoading()) {
    on<LoadCategories>((event, emit) async {
      try {
        final categories = await categoryRepository.getCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        handleError(emit, e);
      }
    });

    add(LoadCategories());
  }
}
