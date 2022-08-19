import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_signed.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_register.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/usecases/sign_up/interfaces/sign_up.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_up/sign_up_cubit.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/presenter/controllers/sign_up/sign_up_state.dart';

class MockSignUpUsecase extends Mock implements ISignUpUsecase {}

class MockDioError extends Mock implements DioError {}

void main() {
  late SignUpCubit signUpCubit;
  late MockSignUpUsecase mockSignUpUsecase;

  setUp(() {
    mockSignUpUsecase = MockSignUpUsecase();
    signUpCubit = SignUpCubit(mockSignUpUsecase);
  });

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

  group('SignUpCubit', () {
    const fakeName = 'any_name';
    const fakeEmail = 'any_email';
    const fakePassword = 'any_password';

    blocTest<SignUpCubit, SignUpState>(
      'should emits [SignUpStatus.loading, SignUpStatus.succeed]',
      build: () {
        when(() => mockSignUpUsecase.execute(fakeUserRegisterDTO))
            .thenAnswer((_) async => Right(fakeUserSignedDTO));

        return signUpCubit;
      },
      act: (cubit) => cubit.signUp(fakeName, fakeEmail, fakePassword),
      expect: () => [
        const SignUpState(status: SignUpStatus.loading),
        const SignUpState(status: SignUpStatus.succeed)
      ],
      verify: (cubit) {
        verify(() => mockSignUpUsecase.execute(fakeUserRegisterDTO)).called(1);
      },
    );

    blocTest<SignUpCubit, SignUpState>(
      'should emits [SignUpStatus.loading, SignUpStatus.failed]',
      build: () {
        when(() => mockSignUpUsecase.execute(fakeUserRegisterDTO))
            .thenAnswer((_) async => Left(Failure('any_error')));

        return signUpCubit;
      },
      act: (cubit) => cubit.signUp(fakeName, fakeEmail, fakePassword),
      expect: () => [
        const SignUpState(status: SignUpStatus.loading),
        const SignUpState(
          status: SignUpStatus.failed,
          errorMessage: 'any_error',
        )
      ],
      verify: (cubit) {
        verify(() => mockSignUpUsecase.execute(fakeUserRegisterDTO)).called(1);
      },
    );
  });
}
