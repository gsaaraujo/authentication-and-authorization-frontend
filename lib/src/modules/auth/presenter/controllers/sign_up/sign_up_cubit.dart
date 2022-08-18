import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/src/app/constants/failure_messages.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_register.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_up/interfaces/sign_up.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpUsecase)
      : super(SignUpState(status: SignUpStatus.initial));

  final ISignUpUsecase _signUpUsecase;

  void signUp(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: SignUpStatus.loading));

      final userRegisterDTO = UserRegisterDTO(
        name: name,
        email: email,
        password: password,
      );

      final userSignedOrFailure = await _signUpUsecase.execute(userRegisterDTO);

      if (userSignedOrFailure.isLeft()) {
        final Failure failure = userSignedOrFailure.left;

        emit(state.copyWith(
          status: SignUpStatus.failed,
          errorMessage: failure.message,
        ));

        return;
      }

      emit(state.copyWith(status: SignUpStatus.succeed));
    } on DioError catch (e) {
      String apiMessage = e.response?.data ?? '';
      String errorMessage = FailureMessages.unexpectedFailure;

      if (apiMessage == 'The email must be a valid email.') {
        errorMessage = 'This email is invalid. Please, try another one.';
      }

      if (apiMessage ==
          'This email address is already associated with another account.') {
        errorMessage = apiMessage;
      }

      if (apiMessage.contains('The password must be between')) {
        errorMessage =
            'The password must be between 8 to 15 characters which contain at least one lowercase letter, one uppercase letter, one numeric digit, and one special character';
      }

      emit(state.copyWith(
        status: SignUpStatus.failed,
        errorMessage: errorMessage,
      ));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      emit(state.copyWith(
        status: SignUpStatus.failed,
        errorMessage: FailureMessages.unexpectedFailure,
      ));
    }
  }
}
