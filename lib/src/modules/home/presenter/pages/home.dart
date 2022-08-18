import 'package:authentication_and_authorization_frontend/src/app/components/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:authentication_and_authorization_frontend/src/app/components/show_snackbar.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/presenter/controllers/home_state.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/presenter/controllers/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCubit = Modular.get<HomeCubit>();

    return BlocListener<HomeCubit, HomeState>(
      bloc: homeCubit,
      listener: (context, state) {
        if (state.status == HomeStatus.failed) {
          showSnackbar(message: state.errorMessage);
        }

        if (state.status == HomeStatus.succeed) {
          Modular.to.navigate('/sign-in');
        }
      },
      child: Scaffold(
        body: Center(
          child: LoadingButton(
            title: 'SIGN OUT !',
            onPress: () => homeCubit.signOut(),
          ),
        ),
      ),
    );
  }
}
