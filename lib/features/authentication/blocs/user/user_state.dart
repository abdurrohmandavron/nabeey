import 'package:equatable/equatable.dart';
import 'package:nabeey/data/models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserCreated extends UserState {
  UserCreated();

  @override
  String toString() => 'UserCreated';
}

class UserLoading extends UserState {
  UserLoading();

  @override
  String toString() => 'UserLoading';
}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserLoaded { User: $user }';
}

class UserEmpty extends UserState {
  UserEmpty();

  @override
  String toString() => 'UserEmpty';
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'UserError { message: $message }';
}
