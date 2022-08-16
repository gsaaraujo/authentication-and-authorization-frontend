import 'package:flutter_modular/flutter_modular.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/pages/splash.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/sign_in.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/interfaces/sign_in.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_in/sign_in_cubit.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<ISignInUsecase>((i) => SignInUsecase(i(), i(), i())),
        Bind.singleton<SignInCubit>((i) => SignInCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
      ];
}
