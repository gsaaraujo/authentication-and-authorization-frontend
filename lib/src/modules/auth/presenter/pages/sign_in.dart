import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:authentication_and_authorization_frontend/src/app/styles/app_texts.dart';
import 'package:authentication_and_authorization_frontend/src/app/styles/app_colors.dart';
import 'package:authentication_and_authorization_frontend/src/app/components/input_text.dart';
import 'package:authentication_and_authorization_frontend/src/app/components/show_snackbar.dart';
import 'package:authentication_and_authorization_frontend/src/app/components/loading_button.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_in/sign_in_state.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_in/sign_in_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final signInCubit = Modular.get<SignInCubit>();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<SignInCubit, SignInState>(
      bloc: signInCubit,
      listener: (context, state) {
        if (state.status == SignInStatus.failed) {
          showSnackbar(message: state.errorMessage);
        }

        if (state.status == SignInStatus.succeed) {
          Modular.to.navigate('/home');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign in',
                        style: AppTexts.heading32Normal,
                      ),
                      const SizedBox(height: 80.0),
                      InputText(
                        label: 'Your email',
                        controller: _emailController,
                        icon: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(height: 16.0),
                      InputText(
                        label: 'Your password',
                        controller: _passwordController,
                        icon: const Icon(Icons.lock_outline),
                        isPassword: true,
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot your password ?',
                            style: AppTexts.heading14Medium.copyWith(
                              color: AppColors.highlight,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 52.0),
                      BlocBuilder<SignInCubit, SignInState>(
                        bloc: signInCubit,
                        builder: (context, state) {
                          return LoadingButton(
                            title: 'Sign in',
                            width: size.width,
                            isLoading: state.status == SignInStatus.loading,
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                signInCubit.signIn(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 80.0),
                      TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            const Text(
                              'Don’t you have an account?',
                              style: AppTexts.heading14Normal,
                            ),
                            Text(
                              'Sign up now !',
                              style: AppTexts.heading14Medium.copyWith(
                                color: AppColors.highlight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
