import 'package:authentication_and_authorization_frontend/src/modules/auth/main/auth_module.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/rest_client/dio_rest_client.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/user_local_storage.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/secure_local_storage.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/rest_client/interfaces/rest_client.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => Dio()),
        Bind.factory((i) => Hive),
        Bind.factory((i) => const FlutterSecureStorage()),
        Bind.factory<IRestClient>((i) => DioRestClient(i()), export: true),
        Bind.factory<ILocalStorage>((i) => UserLocalStorage(i()), export: true),
        Bind.factory<ILocalStorage>(
          (i) => SecureLocalStorage(i()),
          export: true,
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: AuthModule()),
      ];
}
