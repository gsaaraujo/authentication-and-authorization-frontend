import 'package:authentication_and_authorization_frontend/app/constants/keys.dart';
import 'package:authentication_and_authorization_frontend/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/app/services/local_storage/interfaces/local_storage.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/dtos/user_credentials.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/dtos/user_signed.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/models/user.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/ports/user_repository.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/usecases/sign_in/interfaces/sign_in.dart';

class SignInUsecase implements ISignInUsecase {
  final IUserRepository _userRepository;
  final ILocalStorage _localStorage;
  final ILocalStorage _secureLocalStorage;

  SignInUsecase(
    this._userRepository,
    this._localStorage,
    this._secureLocalStorage,
  );

  @override
  Future<Either<Failure, UserSignedDTO>> execute(
    UserCredentialsDTO input,
  ) async {
    final userOrFailure = await _userRepository.signIn(
      input.email,
      input.password,
    );

    if (userOrFailure.isLeft()) {
      final error = userOrFailure.left;
      return Left(error);
    }

    final UserModel userModel = userOrFailure.right;

    await _localStorage.add(
      KeysConst.USER_LOCAL_STORAGE,
      {
        "id": userModel.id,
        "name": userModel.name,
        "email": userModel.email,
      },
    );

    await _secureLocalStorage.add(
      KeysConst.USER_SECURE_LOCAL_STORAGE,
      {
        "accessToken": userModel.accessToken,
        "refreshToken": userModel.refreshToken,
      },
    );

    final userSignedDTO = UserSignedDTO(
      id: userModel.id,
      name: userModel.name,
      email: userModel.email,
    );

    return Right(userSignedDTO);
  }
}
