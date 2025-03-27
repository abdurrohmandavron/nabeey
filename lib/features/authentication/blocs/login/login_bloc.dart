import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/data/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmit>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await authRepository.login(event.phone, event.password);
        emit(LoginSuccess(user!));
      } catch (e) {
        emit(LoginError("Login failed: ${e.toString()}"));
      }
    });
  }
}
