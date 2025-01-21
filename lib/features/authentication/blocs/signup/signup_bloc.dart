import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/data/models/user_model.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/utils/helpers/network_manager.dart';
import 'package:nabeey/features/authentication/blocs/user/user_bloc.dart';
import 'package:nabeey/features/authentication/blocs/user/user_event.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_event.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  /// Variables
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final UserBloc userBloc;

  SignupBloc(this.userBloc) : super(SignupLoading()) {
    on<SignupSubmit>((event, emit) async {
      try {
        // Check Internet Connectivity
        bool isConnected = await NetworkManager().isConnected();
        if (!isConnected) {
          return;
        }

        // Form Validation
        if (!signupFormKey.currentState!.validate()) {
          return;
        }

        // Assign User to variable
        final user = UserModel(
          id: 0,
          userRole: 0,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          email: email.text.trim(),
          phone: '+998${phoneNo.text.trim()}',
          asset: null,
        );

        // Create User
        userBloc.add(CreateUser(user: user, password: password.text.trim()));

        // Emit Success Status
        emit(SignupSuccess(UserBloc.currentUser!));
      } catch (e) {
        ADException(e);
        emit(SignupError('An error occurred: $e'));
      }
    });
  }
}
