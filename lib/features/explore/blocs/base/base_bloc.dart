import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState);

  void handleError(Emitter<S> emit, dynamic error) {
    if (error is SocketException) {
      emit(const ErrorState("Server bilan bog'lanib bo'lmadi.") as S);
    } else {
      ADException(error);
      emit(ErrorState('Error: $error') as S);
    }
  }
}

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class ErrorState extends BaseState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
