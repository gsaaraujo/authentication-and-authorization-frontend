import 'package:authentication_and_authorization_frontend/src/main/app_module.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/ports/user_repository.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/infra/gateways/user_repository.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/splash/splash_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/pages/splash.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/sign_in.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/interfaces/sign_in.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_in/sign_in_cubit.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.factory<IUserRepository>((i) => UserRepository(i())),
        Bind.factory<ISignInUsecase>((i) => SignInUsecase(i(), i(), i())),
        Bind.singleton<SplashCubit>((i) => SplashCubit(i(), i())),
        Bind.singleton<SignInCubit>((i) => SignInCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
      ];
}
