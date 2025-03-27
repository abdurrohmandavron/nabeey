import 'package:equatable/equatable.dart';
import 'package:nabeey/data/models/user_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileNull extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];

  @override
  String toString() => 'ProfileLoaded { user: $user }';
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ProfileError { message: $message }';
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final UserModel user;

  ProfileUpdated(this.user);

  @override
  List<Object?> get props => [user];

  @override
  String toString() => 'ProfileUpdated { user: $user }';
}

class ProfileDeleteSuccess extends ProfileState {}

class ProfileDeleteError extends ProfileState {
  final String message;

  ProfileDeleteError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ProfileDeleteError { message: $message }';
}
