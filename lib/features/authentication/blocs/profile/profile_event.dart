import 'package:equatable/equatable.dart';
import 'package:nabeey/data/models/user_model.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class UpdateProfile extends ProfileEvent {
  final UserModel user;

  UpdateProfile(this.user);

  @override
  List<Object?> get props => [user];
}

class DeleteProfile extends ProfileEvent {
  final String userId;

  DeleteProfile(this.userId);

  @override
  List<Object?> get props => [userId];
}
