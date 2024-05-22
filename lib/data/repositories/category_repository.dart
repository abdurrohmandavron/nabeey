import 'package:flutter/material.dart';
import 'package:nabeey/utils/http/http_client.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

abstract class CategoryRepository {
  @protected
  Future<List<CategoryModel>> getCategories();

  Future<CategoryModel?> getCategory(int categoryId);

  Future<void> createCategory(CategoryModel category);

  Future<void> updateCategory(CategoryModel category);

  Future<void> deleteCategory(int categoryId);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final HttpHelper _httpClient = HttpHelper();

  CategoryRepositoryImpl();

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _httpClient.get(HttpHelper.categoriesR);
    final List<dynamic> categoryListJson = response['data'];
    final List<CategoryModel> categories = categoryListJson.map((categoryJson) => CategoryModel.fromJson(categoryJson)).toList();
    return categories;
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
