import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:authentication_and_authorization_frontend/src/app/styles/app_texts.dart';
import 'package:authentication_and_authorization_frontend/src/app/components/input_text.dart';
import 'package:authentication_and_authorization_frontend/src/app/components/show_snackbar.dart';
import 'package:authentication_and_authorization_frontend/src/app/components/loading_button.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_up/sign_up_cubit.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_up/sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signUpCubit = Modular.get<SignUpCubit>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<SignUpCubit, SignUpState>(
      bloc: signUpCubit,
      listener: (context, state) {
        if (state.status == SignUpStatus.failed) {
          showSnackbar(message: state.errorMessage);
        }

        if (state.status == SignUpStatus.succeed) {
          Modular.to.navigate('/home');
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign up',
                      style: AppTexts.heading32Normal,
                    ),
                    const SizedBox(height: 80.0),
                    InputText(
                      label: 'Your name',
                      controller: _nameController,
                      textInputType: TextInputType.name,
                      icon: const Icon(Icons.person_outline_outlined),
                    ),
                    const SizedBox(height: 16.0),
                    InputText(
                      label: 'Your email',
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      icon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 16.0),
                    InputText(
                      label: 'Your password',
                      controller: _passwordController,
                      textInputType: TextInputType.visiblePassword,
                      icon: const Icon(Icons.lock_outline),
                      isPassword: true,
                    ),
                    const SizedBox(height: 80.0),
                    BlocBuilder<SignUpCubit, SignUpState>(
                      bloc: signUpCubit,
                      builder: (context, state) {
                        return LoadingButton(
                          title: 'Sign up',
                          width: size.width,
                          isLoading: state.status == SignUpStatus.loading,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              signUpCubit.signUp(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
