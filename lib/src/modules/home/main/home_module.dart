import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/pages/sign_in.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:authentication_and_authorization_frontend/src/main/app_module.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/presenter/pages/home.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/data/usecases/sign_out.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/presenter/controllers/home_cubit.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/data/usecases/interfaces/sign_out.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.factory<ISignOutUsecase>((i) => SignOutUsecase(i(), i())),
        Bind.singleton<HomeCubit>((i) => HomeCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/sign-in', child: (context, args) => const SignInPage()),
      ];
}
