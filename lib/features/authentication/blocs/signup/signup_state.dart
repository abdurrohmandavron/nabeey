import 'package:equatable/equatable.dart';
import 'package:nabeey/features/explore/models/user_model.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupLoading extends SignupState {
  SignupLoading();

  @override
  String toString() => 'SignupLoading';
}

class SignupSuccess extends SignupState {
  final UserModel user;

  SignupSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'SignupLoaded { Signup: $user }';
}

class SignupError extends SignupState {
  final String message;

  SignupError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'SignupError { message: $message }';
}
