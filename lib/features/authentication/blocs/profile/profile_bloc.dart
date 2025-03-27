import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/data/repositories/auth_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;

  ProfileBloc({required this.authRepository}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await authRepository.getCurrentUser();
        
        if (user == null) emit(ProfileNull());
        emit(ProfileLoaded(user!));
      } catch (e) {
        emit(ProfileError("Failed to load profile: ${e.toString()}"));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileUpdating());
      try {
        final updatedUser = await authRepository.updateUser(event.user);
        emit(ProfileUpdated(updatedUser!));
      } catch (e) {
        emit(ProfileError("Failed to update profile: ${e.toString()}"));
      }
    });

    on<DeleteProfile>((event, emit) async {
      try {
        await authRepository.deleteUser(event.userId);
        emit(ProfileDeleteSuccess());
      } catch (e) {
        emit(ProfileDeleteError("Failed to delete profile: ${e.toString()}"));
      }
    });

    // add(LoadProfile(userId));
  }
}
