import 'package:flutter/material.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/utils/http/http_client.dart';

abstract class CategoryRepository {
  @protected
  Future<List<CategoryModel>> getCategories();

  Future<CategoryModel?> getCategory(int userId);

  Future<void> createCategory(CategoryModel user);

  Future<void> updateCategory(CategoryModel user);

  Future<void> deleteCategory(int userId);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final HttpHelper _httpClient = HttpHelper();

  CategoryRepositoryImpl();

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _httpClient.get(HttpHelper.categoriesR);
    // Handle API response (error checking, data parsing)
    return response['data'].map((category) => CategoryModel.fromJson(category)).toList();
  }

  @override
  Future<CategoryModel?> getCategory(int categoryId) async {
    final response = await _httpClient.get(HttpHelper.categoryR);
    // Handle API response (error checking, data parsing)
    return response['data'] != null ? CategoryModel.fromJson(response['data']) : null;
  }

  @override
  Future<void> createCategory(CategoryModel category) async {
    // Send create Category request to API
    await _httpClient.post(HttpHelper.categoryC, category.toJson());
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    // Send update Category request to API
    await _httpClient.put(HttpHelper.categoryU + category.id.toString(), category.toJson());
  }

  @override
  Future<void> deleteCategory(int categoryId) async {
    // Send delete Category request to API
    await _httpClient.delete(HttpHelper.categoryD + categoryId.toString());
  }
}
