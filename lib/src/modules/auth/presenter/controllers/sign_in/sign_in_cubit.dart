import 'package:bloc/bloc.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_credentials.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/interfaces/sign_in.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_in/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._signInUsecase)
      : super(SignInState(status: SignInStatus.initial));

  final ISignInUsecase _signInUsecase;

  void signIn(String email, String password) async {
    try {
      final userCredentialsDTO = UserCredentialsDTO(
        email: email,
        password: password,
      );

      final userSignedOrFailure =
          await _signInUsecase.execute(userCredentialsDTO);

      if (userSignedOrFailure.isLeft()) {
        final Failure failure = userSignedOrFailure.left;

        state.copyWith(
          status: SignInStatus.failed,
          errorMessage: failure.message,
        );

        return;
      }

      state.copyWith(
        status: SignInStatus.succeed,
        errorMessage: '',
      );
    } on Exception catch (e) {
      // if (e.message == 'The email must be a valid email.') {
      //   state.copyWith(
      //     status: SignInStatus.succeed,
      //     errorMessage: 'This email is invalid. Please, try another one.',
      //   );
      // }

      // if (e.message == 'Email or password is incorrect.') {
      //   state.copyWith(
      //     status: SignInStatus.succeed,
      //     errorMessage: 'Email or password is incorrect.',
      //   );
      // }

      // state.copyWith(
      //   status: SignInStatus.succeed,
      //   errorMessage: 'Something went wrong. Please try again later.',
      // );
    }
  }
}
