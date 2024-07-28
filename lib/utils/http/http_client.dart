import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nabeey/utils/constants/api_constants.dart';

class HttpHelper {
  HttpHelper();

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('${ADAPIs.baseUrl}/$endpoint'));
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('${ADAPIs.baseUrl}/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('${ADAPIs.baseUrl}/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('${ADAPIs.baseUrl}/$endpoint'),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> getVideoData(String videoId) async {
    final uri = Uri.parse('${ADAPIs.youtubeR}$videoId&key=${ADAPIs.youTubeSecretApiKey}');

    final response = await http.get(uri);

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> getVideoMetaData() async {
    final response = await http.get(Uri.parse(ADAPIs.youtubeR));
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
