import 'package:authentication_and_authorization_frontend/src/app/constants/keys.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/data/usecases/sign_out.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/ports/user_repository.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_info.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_tokens.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockInfoLocalStorage extends Mock implements ILocalStorage<UserInfo> {}

class MockTokensLocalStorage extends Mock implements ILocalStorage<UserTokens> {
}

void main() {
  late SignOutUsecase signOutUsecase;
  late MockInfoLocalStorage mockInfoLocalStorage;
  late MockTokensLocalStorage mockTokensLocalStorage;

  const userLocalStorage = KeysConst.USER_LOCAL_STORAGE;
  const userSecureLocalStorage = KeysConst.USER_SECURE_LOCAL_STORAGE;

  setUp(() {
    mockInfoLocalStorage = MockInfoLocalStorage();
    mockTokensLocalStorage = MockTokensLocalStorage();
    signOutUsecase = SignOutUsecase(
      mockInfoLocalStorage,
      mockTokensLocalStorage,
    );
  });

  test('should sign out and local/secure storage be deleted', () async {
    when(() => mockInfoLocalStorage.delete(userLocalStorage))
        .thenAnswer((_) async => {});

    when(() => mockTokensLocalStorage.delete(userSecureLocalStorage))
        .thenAnswer((_) async => {});

    final signOut = await signOutUsecase.execute();

    expect(signOut.isRight(), isTrue);

    verify(() => mockInfoLocalStorage.delete(userLocalStorage)).called(1);
    verify(() => mockTokensLocalStorage.delete(userSecureLocalStorage))
        .called(1);
  });
}
