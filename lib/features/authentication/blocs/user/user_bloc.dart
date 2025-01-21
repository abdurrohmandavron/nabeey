import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http show MultipartFile;

import 'package:nabeey/data/models/user_model.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/base_repository.dart';
import 'package:nabeey/utils/local_storage/storage_utility.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final baseRepository = BaseRepository();

  /// Variables
  static UserModel? currentUser;

  UserBloc() : super(UserLoading()) {
    on<CreateUser>((event, emit) async {
      try {
        final jsonUser = event.user.toJson(password: event.password);

        final files = event.user.asset != null
            ? [
                await http.MultipartFile.fromPath(
                  'Image',
                  event.user.asset!.filePath,
                  contentType: MediaType('image', 'jpeg'),
                )
              ]
            : <http.MultipartFile>[];

        final user = await baseRepository.create(jsonUser, files);

        currentUser = user;
        LocalStorage().saveData('general', 'currentUser', currentUser);

        emit(UserCreated());
      } catch (e) {
        ADException(e);
        emit(UserError("An error occured while creating user: $e"));
      }
    });

    on<LoadUser>((event, emit) async {
      try {
        currentUser = await baseRepository.getById(event.userId);

        emit(UserLoaded(currentUser!));
      } catch (e) {
        ADException(e);
        emit(UserError('An error occurred while loading user: $e'));
      }
    });
  }
}
