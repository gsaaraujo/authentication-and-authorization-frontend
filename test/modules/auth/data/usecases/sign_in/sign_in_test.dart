import 'package:authentication_and_authorization_frontend/app/constants/keys.dart';
import 'package:authentication_and_authorization_frontend/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/app/utils/local_storage/interfaces/local_storage.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/dtos/user_credentials.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/dtos/user_signed.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/models/user.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/ports/user_repository.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/usecases/sign_in/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockLocalStorage extends Mock implements ILocalStorage {}

class AnyFailure extends Failure {}

void main() {
  late SignInUsecase signInUsecase;
  late IUserRepository userRepository;
  late ILocalStorage localStorage;
  late ILocalStorage secureLocalStorage;

  setUp(() {
    userRepository = MockUserRepository();
    localStorage = MockLocalStorage();
    secureLocalStorage = MockLocalStorage();

    signInUsecase = SignInUsecase(
      userRepository,
      localStorage,
      secureLocalStorage,
    );
  });

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

  const fakeUserCredentialsDTO = UserCredentialsDTO(
    email: 'any_email',
    password: 'any_password',
  );

  test('should sign in and return UserSignedDTO', () async {
    const fakeEmail = 'any_email';
    const fakePassword = 'any_password';
    const fakeLocalStorageKey = KeysConst.USER_LOCAL_STORAGE;
    const fakeSecureLocalStorageKey = KeysConst.USER_SECURE_LOCAL_STORAGE;

    final fakeLocalStorage = {
      "id": fakeUserModel.id,
      "name": fakeUserModel.name,
      "email": fakeUserModel.email,
    };

    final fakeSecureLocalStorage = {
      "accessToken": fakeUserModel.accessToken,
      "refreshToken": fakeUserModel.refreshToken,
    };

    when(() => userRepository.signIn(fakeEmail, fakePassword))
        .thenAnswer((_) async => Right(fakeUserModel));

    when(() => localStorage.add(
          fakeLocalStorageKey,
          fakeLocalStorage,
        )).thenAnswer((_) async => {});

    when(() => secureLocalStorage.add(
          fakeSecureLocalStorageKey,
          fakeSecureLocalStorage,
        )).thenAnswer((_) async => {});

    final signInOrFailure = await signInUsecase.execute(fakeUserCredentialsDTO);

    expect(signInOrFailure.isRight(), isTrue);
    expect(signInOrFailure.right, fakeUserSignedDTO);
  });

  test(
      'should not sign in and return Failure if userRepository.signIn returns Failure',
      () async {
    const fakeEmail = 'any_email';
    const fakePassword = 'any_password';

    when(() => userRepository.signIn(fakeEmail, fakePassword))
        .thenAnswer((_) async => Left(AnyFailure()));

    final signInOrFailure = await signInUsecase.execute(fakeUserCredentialsDTO);

    expect(signInOrFailure.isLeft(), isTrue);
    expect(signInOrFailure.left, isA<AnyFailure>());
  });
}
