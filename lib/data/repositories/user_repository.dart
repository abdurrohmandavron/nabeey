import 'package:flutter/material.dart';
import 'package:nabeey/utils/http/http_client.dart';
import 'package:nabeey/utils/constants/api_constants.dart';
import 'package:nabeey/features/explore/models/user_model.dart';

abstract class UserRepository {
  @protected
  Future<List<UserModel>> getUsers();

  Future<UserModel?> getUser(int userId);

  Future<UserModel> createUser(UserModel user, String password);

  Future<UserModel> updateUser(UserModel user);

  Future<void> deleteUser(int userId);
}

class UserRepositoryImpl implements UserRepository {
  final HttpHelper _httpClient = HttpHelper();

  UserRepositoryImpl();

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _httpClient.get(ADAPIs.usersR);
      
      final List<dynamic> userListJson = response['data'];
      final List<UserModel> users = userListJson.map((userJson) => UserModel.fromJson(userJson)).toList();

      return users;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUser(int userId) async {
    final response = await _httpClient.get(ADAPIs.userR);
    // Handle API response (error checking, data parsing)
    return response['data'] != null ? UserModel.fromJson(response['data']) : null;
  }

  @override
  Future<UserModel> createUser(UserModel user, String password) async {
    // Send create User request to API
    final response = await _httpClient.signup(user: user, password: password);
   
    return response['data'] != null ? UserModel.fromJson(response['data']) : UserModel.empty();
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    // Send update User request to API
    final response = await _httpClient.put(ADAPIs.userU + user.id.toString(), user.toJson());
    return response['data'] != null ? UserModel.fromJson(response['data']) : UserModel.empty();
  }

  @override
  Future<void> deleteUser(int userId) async {
    // Send delete User request to API
    await _httpClient.delete(ADAPIs.userD + userId.toString());
  }
}
