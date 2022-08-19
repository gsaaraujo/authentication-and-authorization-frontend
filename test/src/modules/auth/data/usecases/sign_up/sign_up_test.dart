import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_register.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_up/sign_up.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:authentication_and_authorization_frontend/src/app/constants/keys.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/models/user.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_signed.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/ports/user_repository.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_credentials.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/sign_in.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_info.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_tokens.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockInfoLocalStorage extends Mock implements ILocalStorage<UserInfo> {}

class MockTokensLocalStorage extends Mock implements ILocalStorage<UserTokens> {
}

void main() {
  late SignUpUsecase signUpUsecase;
  late MockUserRepository mockUserRepository;
  late MockInfoLocalStorage mockInfoLocalStorage;
  late MockTokensLocalStorage mockTokensLocalStorage;

  const fakeName = 'any_name';
  const fakeEmail = 'any_email';
  const fakePassword = 'any_password';

  const fakeUserInfo = UserInfo(
    id: 'any_id',
    name: 'any_name',
    email: 'any_email',
  );

  const fakeUserTokens = UserTokens(
    accessToken: 'any_accessToken',
    refreshToken: 'any_refreshToken',
  );

  const fakeUserRegisterDTO = UserRegisterDTO(
    name: 'any_name',
    email: 'any_email',
    password: 'any_password',
  );

  const fakeUserSignedDTO = UserSignedDTO(
    id: 'any_id',
    name: 'any_name',
    email: 'any_email',
  );

  const fakeUserModel = UserModel(
    id: 'any_id',
    name: 'any_name',
    email: 'any_email',
    accessToken: 'any_accessToken',
    refreshToken: 'any_refreshToken',
  );

  const userLocalStorage = KeysConst.USER_LOCAL_STORAGE;
  const userSecureLocalStorage = KeysConst.USER_SECURE_LOCAL_STORAGE;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockInfoLocalStorage = MockInfoLocalStorage();
    mockTokensLocalStorage = MockTokensLocalStorage();
    signUpUsecase = SignUpUsecase(
      mockUserRepository,
      mockInfoLocalStorage,
      mockTokensLocalStorage,
    );
  });

  test('should sign up and return UserSignedDTO', () async {
    when(() => mockUserRepository.signUp(fakeName, fakeEmail, fakePassword))
        .thenAnswer((_) async => fakeUserModel);

    when(() => mockInfoLocalStorage.add(userLocalStorage, fakeUserInfo))
        .thenAnswer((_) async => {});

    when(() =>
            mockTokensLocalStorage.add(userSecureLocalStorage, fakeUserTokens))
        .thenAnswer((_) async => {});

    final userSigned = await signUpUsecase.execute(fakeUserRegisterDTO);

    expect(userSigned.isRight(), isTrue);
    expect(userSigned.right, fakeUserSignedDTO);
    verify(() => mockUserRepository.signUp(fakeName, fakeEmail, fakePassword))
        .called(1);
    verify(
      () => mockInfoLocalStorage.add(userLocalStorage, fakeUserInfo),
    ).called(1);
    verify(
      () => mockTokensLocalStorage.add(userSecureLocalStorage, fakeUserTokens),
    ).called(1);
  });
}
