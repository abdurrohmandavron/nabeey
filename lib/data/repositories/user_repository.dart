import '../../features/explore/models/user_model.dart';

import 'base_repository.dart';

class UserRepository extends BaseRepository<UserModel> {

  Future<UserModel> createUser(UserModel user, String password) async {
    try {
      final response = await httpClient.signup(user: user, password: password);
      return response['data'] != null ? fromJson(response['data']) : empty();
    } catch (e) {
      rethrow;
    }
  }

}
