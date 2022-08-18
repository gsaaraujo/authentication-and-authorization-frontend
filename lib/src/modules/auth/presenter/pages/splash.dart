import 'package:authentication_and_authorization_frontend/src/app/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/splash/splash_state.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/splash/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashCubit = Modular.get<SplashCubit>()..redirectUser();

    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        bloc: splashCubit,
        listener: (context, state) {
          if (state.status == SplashStatus.userAlreadySignedIn) {
            Modular.to.navigate('/home');
          }

          if (state.status == SplashStatus.userNotSignedIn) {
            Modular.to.navigate('/sign-in');
          }

          if (state.status == SplashStatus.failed) {
            showSnackbar(message: state.errorMessage);
          }
        },
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 115.0,
            height: 174.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
