import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../utils/constants/api_constants.dart';

class HttpHelper {
  HttpHelper();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  final String _baseUrl = kDebugMode ? 'nabeey2.ddns.net:8080' : dotenv.env['BASE_URL']!;
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

  Future<Map<String, dynamic>> postMultipart(String path, Map<String, dynamic> jsonData, List<http.MultipartFile> files) async {
    return await _request('POST-MULTIPART', path, jsonData: jsonData, files: files);
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

    final response = await http.get(uri);

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> _request(String method, String path, {Map<String, dynamic>? jsonData, List<http.MultipartFile>? files}) async {
    try {
      final uri = Uri.http(_baseUrl, path);
      http.Response response;

      switch (method) {
        case 'POST':
          response = await http.post(uri, headers: _headers, body: json.encode(jsonData));
          break;
        case 'POST-MULTIPART':
          var request = http.MultipartRequest('POST', uri);
          
          request.fields.addAll(jsonData as Map<String, String>);
          request.headers.addAll(_headers);
          if (files != null) request.files.addAll(files);

          response = await http.Response.fromStream(await request.send());
          break;
        case 'PUT':
          response = await http.put(uri, headers: _headers, body: json.encode(jsonData));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: _headers);
          break;
        case 'GET':
        default:
          response = await http.get(uri, headers: _headers);
          break;
      }

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
