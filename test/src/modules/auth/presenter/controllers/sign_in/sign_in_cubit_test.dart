import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_signed.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_credentials.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_in/interfaces/sign_in.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_in/sign_in_state.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_in/sign_in_cubit.dart';

class MockSignInUsecase extends Mock implements ISignInUsecase {}

class MockDioError extends Mock implements DioError {}

void main() {
  late SignInCubit signInCubit;
  late MockSignInUsecase mockSignInUsecase;

  setUp(() {
    mockSignInUsecase = MockSignInUsecase();
    signInCubit = SignInCubit(mockSignInUsecase);
  });

  final mockDioError = MockDioError();

  const fakeUserCredentialsDTO = UserCredentialsDTO(
    email: 'any_email',
    password: 'any_password',
  );

  const fakeUserSignedDTO = UserSignedDTO(
    id: 'any_id',
    name: 'any_name',
    email: 'any_email',
  );

  group('SignInCubit', () {
    const fakeEmail = 'any_email';
    const fakePassword = 'any_password';

    blocTest<SignInCubit, SignInState>(
      'should emits [SignInStatus.loading, SignInStatus.succeed]',
      build: () {
        when(() => mockSignInUsecase.execute(fakeUserCredentialsDTO))
            .thenAnswer((_) async => Right(fakeUserSignedDTO));

        return signInCubit;
      },
      act: (cubit) => cubit.signIn(fakeEmail, fakePassword),
      expect: () => [
        const SignInState(status: SignInStatus.loading),
        const SignInState(status: SignInStatus.succeed)
      ],
      verify: (cubit) {
        verify(() => mockSignInUsecase.execute(fakeUserCredentialsDTO))
            .called(1);
      },
    );

    blocTest<SignInCubit, SignInState>(
      'should emits [SignInStatus.loading, SignInStatus.failed]',
      build: () {
        when(() => mockSignInUsecase.execute(fakeUserCredentialsDTO))
            .thenAnswer((_) async => Left(Failure('any_error')));

        return signInCubit;
      },
      act: (cubit) => cubit.signIn(fakeEmail, fakePassword),
      expect: () => [
        const SignInState(status: SignInStatus.loading),
        const SignInState(
          status: SignInStatus.failed,
          errorMessage: 'any_error',
        )
      ],
      verify: (cubit) {
        verify(() => mockSignInUsecase.execute(fakeUserCredentialsDTO))
            .called(1);
      },
    );
  });
}
