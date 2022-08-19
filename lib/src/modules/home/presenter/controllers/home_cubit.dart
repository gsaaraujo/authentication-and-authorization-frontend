import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/data/usecases/interfaces/sign_out.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/presenter/controllers/home_state.dart';
import 'package:flutter/material.dart';

class HomeCubit extends Cubit<HomeState> {
  final ISignOutUsecase _signOutUsecase;

  HomeCubit(
    this._signOutUsecase,
  ) : super(const HomeState(status: HomeStatus.initial));

  void signOut() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final signOutOrFailure = await _signOutUsecase.execute();

      if (signOutOrFailure.isLeft()) {
        final Failure failure = signOutOrFailure.left;

        emit(state.copyWith(
          status: HomeStatus.failed,
          errorMessage: failure.message,
        ));

        return;
      }

      emit(state.copyWith(status: HomeStatus.succeed));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failed));
    }
  }
}
