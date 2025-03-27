import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmit extends LoginEvent {
  final String phone;
  final String password;

  LoginSubmit({required this.phone, required this.password});

  @override
  List<Object> get props => [phone, password];
} 