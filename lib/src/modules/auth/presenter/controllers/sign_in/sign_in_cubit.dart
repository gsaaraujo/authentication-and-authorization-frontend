import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/src/app/constants/failure_messages.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_credentials.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/interfaces/sign_in.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_in/sign_in_state.dart';
import 'package:flutter/cupertino.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._signInUsecase)
      : super(SignInState(status: SignInStatus.initial));

  final ISignInUsecase _signInUsecase;

  void signIn(String email, String password) async {
    try {
      emit(state.copyWith(status: SignInStatus.loading));

      final userCredentialsDTO = UserCredentialsDTO(
        email: email,
        password: password,
      );

      final userSignedOrFailure =
          await _signInUsecase.execute(userCredentialsDTO);

      if (userSignedOrFailure.isLeft()) {
        final Failure failure = userSignedOrFailure.left;

        emit(state.copyWith(
          status: SignInStatus.failed,
          errorMessage: failure.message,
        ));

        return;
      }

      emit(state.copyWith(status: SignInStatus.succeed));
    } on DioError catch (e) {
      String apiMessage = e.response?.data ?? '';
      String errorMessage = FailureMessages.unexpectedFailure;

      if (apiMessage == 'The email must be a valid email.') {
        errorMessage = 'This email is invalid. Please, try another one.';
      }

      if (apiMessage == 'Email or password is incorrect.') {
        errorMessage = 'Email or password is incorrect.';
      }

      emit(state.copyWith(
        status: SignInStatus.failed,
        errorMessage: errorMessage,
      ));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      emit(state.copyWith(
        status: SignInStatus.failed,
        errorMessage: FailureMessages.unexpectedFailure,
      ));
    }
  }
}
