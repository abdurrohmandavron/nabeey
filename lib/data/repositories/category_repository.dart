import '../../utils/constants/api_constants.dart';
import '../../features/explore/models/category_model.dart';

import 'base_repository.dart';

class CategoryRepository extends BaseRepository<CategoryModel> {
  @override
  CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel.fromJson(json);

  @override
  CategoryModel empty() => CategoryModel.empty();

  Future<List<CategoryModel>> getCategories() => getAll(ADAPIs.categoriesR);

  Future<CategoryModel?> getCategory(int categoryId) => getById(ADAPIs.categoryR, categoryId);

  Future<void> createCategory(CategoryModel category) => create(ADAPIs.categoryC, category.toJson());

  Future<void> updateCategory(CategoryModel category) => update(ADAPIs.categoryU, category.id, category.toJson());

  Future<void> deleteCategory(int categoryId) => delete(ADAPIs.categoryD, categoryId);
}
