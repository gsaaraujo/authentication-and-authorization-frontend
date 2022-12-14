import 'package:authentication_and_authorization_frontend/src/app/constants/failure_messages.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_and_authorization_frontend/src/app/constants/keys.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_info.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_tokens.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/splash/splash_state.dart';
import 'package:flutter/material.dart';

class SplashCubit extends Cubit<SplashState> {
  final ILocalStorage<UserInfo> _localStorage;
  final ILocalStorage<UserTokens> _secureLocalStorage;

  SplashCubit(
    this._localStorage,
    this._secureLocalStorage,
  ) : super(const SplashState(status: SplashStatus.initial));

  void redirectUser() async {
    try {
      emit(state.copyWith(status: SplashStatus.loading));

      final userInfo = await _localStorage.read(KeysConst.USER_LOCAL_STORAGE);
      final userTokens = await _secureLocalStorage.read(
        KeysConst.USER_SECURE_LOCAL_STORAGE,
      );

      if (userInfo == null || userTokens == null) {
        emit(state.copyWith(status: SplashStatus.userNotSignedIn));
        return;
      }

      emit(state.copyWith(status: SplashStatus.userAlreadySignedIn));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      emit(state.copyWith(
        status: SplashStatus.failed,
        errorMessage: FailureMessages.unexpectedFailure,
      ));
    }
  }
}
