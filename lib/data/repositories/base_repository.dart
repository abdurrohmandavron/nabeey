import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/models/user_model.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/utils/constants/api_constants.dart';

import '../../utils/http/http_client.dart';

class BaseRepository<T> {
  BaseRepository() {
    setFunctions();
  }

  final HttpHelper httpClient = HttpHelper();

  Future<T> getById(int id) async {
    try {
      final String apiEndpoint = ADAPIs.endpoints['GET']![T]! + id.toString();
      final response = await httpClient.getById(id, apiEndpoint);

      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> getByCategoryId(int categoryId) async {
    try {
      String apiEndpoint = ADAPIs.endpoints['GETBYCATEGORY']![T]! + categoryId.toString();
      final response = await httpClient.get(apiEndpoint);

      final List<dynamic> jsonList = response['data'] ?? [];
      return jsonList.map<T>((json) => fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> getAll() async {
    try {
      String apiUrl = ADAPIs.endpoints['GETALL']![T]!;
      final response = await httpClient.get(apiUrl);

      return response['data'].map<T>((json) => fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<T> create(Map<String, dynamic> json) async {
    try {
      final String apiEndpoint = ADAPIs.endpoints['CREATE']![T]!;
      final response = await httpClient.post(apiEndpoint, json);

      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<T> update(int id, Map<String, dynamic> json) async {
    try {
      final apiEndpoint = ADAPIs.endpoints['UPDATE']![T]!;
      final response = await httpClient.put(id, apiEndpoint, json);

      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    try {
      final String apiEndpoint = ADAPIs.endpoints['DELETE']![T]! + id.toString();
      await httpClient.delete(id, apiEndpoint);
    } catch (e) {
      rethrow;
    }
  }

  T Function(Map<String, dynamic>) fromJson = CategoryModel.fromJson as T Function(Map<String, dynamic>);
  T Function() empty = CategoryModel.empty as T Function();

  void setFunctions() {
    if (T == CategoryModel) {
      return;
    } else if (T == UserModel) {
      fromJson = UserModel.fromJson as T Function(Map<String, dynamic>);
      empty = UserModel.empty as T Function();
    } else if (T == ArticleModel) {
      fromJson = ArticleModel.fromJson as T Function(Map<String, dynamic>);
      empty = ArticleModel.empty as T Function();
    } else if (T == BookModel) {
      fromJson = BookModel.fromJson as T Function(Map<String, dynamic>);
      empty = BookModel.empty as T Function();
    } else if (T == AudioModel) {
      fromJson = AudioModel.fromJson as T Function(Map<String, dynamic>);
      empty = AudioModel.empty as T Function();
    } else if (T == VideoModel) {
      fromJson = VideoModel.fromJson as T Function(Map<String, dynamic>);
      empty = VideoModel.empty as T Function();
    }
  }
}
