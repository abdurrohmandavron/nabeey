import '../../utils/http/http_client.dart';

abstract class BaseRepository<T> {
  final HttpHelper httpClient = HttpHelper();

  Future<List<T>> getAll(String apiUrl) async {
    try {
      final response = await httpClient.get(apiUrl);
      final List<dynamic> jsonList = response['data'] ?? [];
      return jsonList.map((json) => fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<T> getById(String apiUrl, int id) async {
    try {
      final response = await httpClient.getById(id, apiUrl);
      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<T> create(String apiUrl, Map<String, dynamic> json) async {
    try {
      final response = await httpClient.post(apiUrl, json);
      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<T> update(String apiUrl, int id, Map<String, dynamic> json) async {
    try {
      final response = await httpClient.put(id, apiUrl, json);
      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String apiUrl, int id) async {
    try {
      await httpClient.delete(id, apiUrl);
    } catch (e) {
      rethrow;
    }
  }

  T fromJson(Map<String, dynamic> json);
  T empty();
}
