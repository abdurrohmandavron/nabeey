import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../utils/constants/api_constants.dart';
import '../../features/explore/models/user_model.dart';

class HttpHelper {
  HttpHelper();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  final String _baseUrl = dotenv.env['BASE_URL']!;
  final String _youtubeBase = ADAPIs.youtubeBase;

  Future<Map<String, dynamic>> get(String path) async {
    return await _request('GET', path);
  }

  Future<Map<String, dynamic>> getById(int id, String path) async {
    return await _request('GET', '$path/$id');
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> jsonData) async {
    return await _request('POST', path, jsonData: jsonData);
  }

  Future<Map<String, dynamic>> put(int id, String path, Map<String, dynamic> jsonData) async {
    return await _request('PUT', '$path/$id', jsonData: jsonData);
  }

  Future<Map<String, dynamic>> delete(int id, String path) async {
    return await _request('DELETE', '$path/$id');
  }

  Future<Map<String, dynamic>> getVideoData(String videoId) async {
    final uri = Uri.https(
      _youtubeBase,
      ADAPIs.youtubeR,
      {
        'id': videoId,
        'part': 'snippet',
        'key': dotenv.env['YOUTUBE_DATA_API_KEY'],
      },
    );

    return _request('GET', uri.toString());
  }

  Future<Map<String, dynamic>> signup({
    required UserModel user,
    required String password,
  }) async {
    try {
      final url = Uri.http(_baseUrl, ADAPIs.endpoints['CREATE']![UserModel]!);
      var request = http.MultipartRequest('POST', url)
        ..fields['firstName'] = user.firstName
        ..fields['lastName'] = user.lastName
        ..fields['email'] = user.email
        ..fields['phone'] = user.phone
        ..fields['password'] = password;

      if (user.asset != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'Image',
            user.asset!.filePath,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to sign up user: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> _request(String method, String path, {Map<String, dynamic>? jsonData}) async {
    try {
      final uri = Uri.http(_baseUrl, path);
      http.Response response;

      switch (method) {
        case 'POST':
          response = await http.post(uri, headers: _headers, body: json.encode(jsonData));
          break;
        case 'PUT':
          response = await http.put(uri, headers: _headers, body: json.encode(jsonData));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: _headers);
          break;
        case 'GET':
        default:
          response = await http.get(uri);
          break;
      }

      return _handleResponse(response);
    } catch (e) {
      throw Exception('HTTP Request failed: ${e.toString()}');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode} - ${response.body}');
    }
  }
}
