import 'package:nabeey/data/models/user_model.dart';
import 'package:nabeey/data/repositories/base_repository.dart';
import 'package:nabeey/utils/helpers/network_manager.dart';
import 'package:nabeey/utils/http/http_client.dart';
import 'package:nabeey/utils/local_storage/storage_utility.dart';
import 'package:nabeey/utils/constants/api_constants.dart';

import 'package:nabeey/utils/logging/logger.dart';

class AuthRepository {
  final NetworkManager networkManager;
  final BaseRepository<UserModel> userRepository;

  AuthRepository({
    required this.userRepository,
    required this.networkManager,
  });

  Future<UserModel?> signUp(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
  ) async {
    if (!await networkManager.isConnected()) {
      throw Exception("No internet connection");
    }

    final jsonUser = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "password": password,
    };

    try {
      final createdUser = await userRepository.create(jsonUser);

      await LocalStorage().saveData('general', 'currentUser', createdUser);

      return createdUser;
    } catch (e) {
      throw Exception("Sign up failed: $e");
    }
  }

  Future<UserModel?> login(String phone, String password) async {
    if (!await networkManager.isConnected()) {
      throw Exception("No internet connection");
    }

    final credentials = {
      "phone": phone,
      "password": password,
    };

    try {
      String apiUrl = ADAPIs.endpoints['LOGIN']![UserModel]!;
      final response = await HttpHelper().post(apiUrl, credentials);

      final loggedUser = response['data'] != null
          ? UserModel.fromJson(response['data'])
          : UserModel.empty();
      await LocalStorage().saveData('general', 'currentUser', loggedUser);

      return loggedUser;
    } catch (e) {
      LoggerHelper.error('Repository operation failed: $e');
      throw Exception("Can't logged in ${e.toString}");
    }
  }

  Future<void> logout() async {
    await LocalStorage().removeData('general', 'currentUser');
  }

  Future<UserModel?> getCurrentUser() async {
    return LocalStorage().readData<UserModel>('general', 'currentUser');
  }

  Future<UserModel?> updateUser(UserModel user) async {
    return UserModel.empty();
  }

  Future<void> deleteUser(String userId) async {}
}
