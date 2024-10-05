import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/user_repository.dart';
import 'package:nabeey/features/explore/models/user_model.dart';
import 'package:nabeey/utils/local_storage/storage_utility.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = UserRepository();

  /// Variables
  static UserModel? currentUser;

  UserBloc() : super(UserLoading()) {
    on<CreateUser>((event, emit) async {
      try {
        final user = await userRepository.createUser(event.user, event.password);
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
        currentUser = await userRepository.getUser(event.userId);

        emit(UserLoaded(currentUser!));
      } catch (e) {
        ADException(e);
        emit(UserError('An error occurred while loading user: $e'));
      }
    });
  }
}
