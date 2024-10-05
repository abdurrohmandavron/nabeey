import '../../utils/constants/api_constants.dart';
import '../../features/explore/models/user_model.dart';

import 'base_repository.dart';

class UserRepository extends BaseRepository<UserModel> {
  @override
  UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

  @override
  UserModel empty() => UserModel.empty();

  Future<List<UserModel>> getUsers() => getAll(ADAPIs.usersR);

  Future<UserModel> getUser(int userId) => getById(ADAPIs.userR, userId);

  Future<UserModel> createUser(UserModel user, String password) async {
    try {
      final response = await httpClient.signup(user: user, password: password);
      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(int userId, UserModel newUser) => update(ADAPIs.userU, userId, newUser.toJson());

  Future<void> deleteUser(int userId) => delete(ADAPIs.userD, userId);
}
