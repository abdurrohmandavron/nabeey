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
    _setFunctions();
  }

  final HttpHelper httpClient = HttpHelper();

  late final T Function(Map<String, dynamic>) fromJson;
  late final T Function() empty;

  int? categoryId;

  Future<T> getById(int id) async {
    try {
      final String apiEndpoint = ADAPIs.endpoints['GET']![T]! + id.toString();
      final response = await httpClient.getById(id, apiEndpoint);

      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> getByCategoryId() async {
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

      final List<dynamic> jsonList = response['data'] ?? [];
      return jsonList.map((json) => fromJson(json)).toList();
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

  void _setFunctions() {
    if (T == CategoryModel) {
      fromJson = (json) => CategoryModel.fromJson(json) as T;
      empty = () => CategoryModel.empty() as T;
    } else if (T == UserModel) {
      fromJson = (json) => UserModel.fromJson(json) as T;
      empty = () => UserModel.empty() as T;
    } else if (T == ArticleModel) {
      fromJson = (json) => ArticleModel.fromJson(json) as T;
      empty = () => ArticleModel.empty() as T;
    } else if (T == BookModel) {
      fromJson = (json) => BookModel.fromJson(json) as T;
      empty = () => BookModel.empty() as T;
    } else if (T == AudioModel) {
      fromJson = (json) => AudioModel.fromJson(json) as T;
      empty = () => AudioModel.empty() as T;
    } else if (T == VideoModel) {
      fromJson = (json) => VideoModel.fromJson(json) as T;
      empty = () => VideoModel.empty() as T;
    } else {
      throw UnsupportedError("Type not supported: $T");
    }
  }
}
