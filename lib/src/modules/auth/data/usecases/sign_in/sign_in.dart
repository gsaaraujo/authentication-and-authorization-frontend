import 'package:authentication_and_authorization_frontend/src/app/constants/keys.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_info.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_tokens.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_signed.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_credentials.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/ports/user_repository.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/interfaces/sign_in.dart';

class SignInUsecase implements ISignInUsecase {
  final IUserRepository _userRepository;
  final ILocalStorage<UserInfo> _localStorage;
  final ILocalStorage<UserTokens> _secureLocalStorage;

  SignInUsecase(
    this._userRepository,
    this._localStorage,
    this._secureLocalStorage,
  );

  @override
  Future<Either<Failure, UserSignedDTO>> execute(
    UserCredentialsDTO input,
  ) async {
    final userModel = await _userRepository.signIn(
      input.email,
      input.password,
    );

    await _localStorage.add(
      KeysConst.USER_LOCAL_STORAGE,
      UserInfo(id: userModel.id, name: userModel.name, email: userModel.email),
    );

    await _secureLocalStorage.add(
      KeysConst.USER_SECURE_LOCAL_STORAGE,
      UserTokens(
        accessToken: userModel.accessToken,
        refreshToken: userModel.refreshToken,
      ),
    );

    final userSignedDTO = UserSignedDTO(
      id: userModel.id,
      name: userModel.name,
      email: userModel.email,
    );

    return Right(userSignedDTO);
  }
}
