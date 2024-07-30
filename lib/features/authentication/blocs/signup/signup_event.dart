import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupSubmit extends SignupEvent {
  SignupSubmit();

  @override
  List<Object> get props => [];
}
