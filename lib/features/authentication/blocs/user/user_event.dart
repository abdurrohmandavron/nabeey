import 'package:equatable/equatable.dart';
import 'package:nabeey/data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateUser extends UserEvent {
  final UserModel user;
  final String password;

  CreateUser({required this.user, required this.password});

  @override
  List<Object> get props => [user, password];
}

class LoadUser extends UserEvent {
  final int userId;

  LoadUser({required this.userId});

  @override
  List<Object> get props => [userId];
}
