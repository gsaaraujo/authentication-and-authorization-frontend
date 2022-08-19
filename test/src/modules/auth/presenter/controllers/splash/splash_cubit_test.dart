import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:authentication_and_authorization_frontend/src/app/constants/keys.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_info.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_tokens.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/splash/splash_cubit.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/splash/splash_state.dart';

class MockInfoLocalStorage extends Mock implements ILocalStorage<UserInfo> {}

class MockTokensLocalStorage extends Mock implements ILocalStorage<UserTokens> {
}

void main() {
  late SplashCubit splashCubit;
  late MockInfoLocalStorage mockInfoLocalStorage;
  late MockTokensLocalStorage mockTokensLocalStorage;

  setUp(() {
    mockInfoLocalStorage = MockInfoLocalStorage();
    mockTokensLocalStorage = MockTokensLocalStorage();
    splashCubit = SplashCubit(mockInfoLocalStorage, mockTokensLocalStorage);
  });

  const userLocalStorage = KeysConst.USER_LOCAL_STORAGE;
  const userSecureLocalStorage = KeysConst.USER_SECURE_LOCAL_STORAGE;

  const fakeUserInfo = UserInfo(
    id: 'any_id',
    name: 'any_name',
    email: 'any_email',
  );

  const fakeUserTokens = UserTokens(
    accessToken: 'any_accessToken',
    refreshToken: 'any_refreshToken',
  );

  group('SplashCubit', () {
    blocTest<SplashCubit, SplashState>(
      'should emits [SplashStatus.loading, SplashStatus.userAlreadySignedIn]',
      build: () {
        when(() => mockInfoLocalStorage.read(userLocalStorage))
            .thenAnswer((_) async => fakeUserInfo);

        when(() => mockTokensLocalStorage.read(userSecureLocalStorage))
            .thenAnswer((_) async => fakeUserTokens);

        return splashCubit;
      },
      act: (cubit) => cubit.redirectUser(),
      expect: () => [
        const SplashState(status: SplashStatus.loading),
        const SplashState(status: SplashStatus.userAlreadySignedIn)
      ],
      verify: (cubit) {
        verify(() => mockInfoLocalStorage.read(userLocalStorage)).called(1);
        verify(() => mockTokensLocalStorage.read(userSecureLocalStorage))
            .called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'should emits [SplashStatus.loading, SplashStatus.userNotSignedIn]',
      build: () {
        when(() => mockInfoLocalStorage.read(userLocalStorage))
            .thenAnswer((_) async => null);

        when(() => mockTokensLocalStorage.read(userSecureLocalStorage))
            .thenAnswer((_) async => null);

        return splashCubit;
      },
      act: (cubit) => cubit.redirectUser(),
      expect: () => [
        const SplashState(status: SplashStatus.loading),
        const SplashState(status: SplashStatus.userNotSignedIn)
      ],
      verify: (cubit) {
        verify(() => mockInfoLocalStorage.read(userLocalStorage)).called(1);
        verify(() => mockTokensLocalStorage.read(userSecureLocalStorage))
            .called(1);
      },
    );
  });
}
