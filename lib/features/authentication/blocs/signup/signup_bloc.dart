import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/data/repositories/auth_repository.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_event.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_state.dart';
import 'package:nabeey/utils/helpers/network_manager.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  /// Variables
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(SignupLoading()) {
    on<SignupSubmit>((event, emit) async {
      emit(SignupLoading());
      try {
        // Check Internet Connectivity
        bool isConnected = await NetworkManager().isConnected();
        if (!isConnected) {
          return;
        }

        // // Form Validation
        if (!signupFormKey.currentState!.validate()) {
          return;
        }

        final user = await authRepository.signUp(
          firstName.text.trim(),
          lastName.text.trim(),
          email.text.trim(),
          '+998${phoneNo.text.trim()}',
          password.text.trim(),
        );
        emit(SignupSuccess(user!));
      } catch (e) {
        emit(SignupError("Signup failed: ${e.toString()}"));
      }
    });
  }
}
