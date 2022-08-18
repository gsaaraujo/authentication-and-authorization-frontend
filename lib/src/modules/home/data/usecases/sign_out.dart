import 'package:authentication_and_authorization_frontend/src/app/constants/keys.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_info.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_tokens.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/data/usecases/interfaces/sign_out.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';

class SignOutUsecase implements ISignOutUsecase {
  final ILocalStorage<UserInfo> _localStorage;
  final ILocalStorage<UserTokens> _secureLocalStorage;

  SignOutUsecase(this._localStorage, this._secureLocalStorage);

  @override
  Future<Either<Failure, void>> execute() async {
    await _localStorage.delete(KeysConst.USER_LOCAL_STORAGE);
    await _secureLocalStorage.delete(KeysConst.USER_SECURE_LOCAL_STORAGE);

    return Right(null);
  }
}
