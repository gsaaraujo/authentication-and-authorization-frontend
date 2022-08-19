import 'package:authentication_and_authorization_frontend/src/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/data/usecases/interfaces/sign_out.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/presenter/controllers/home_cubit.dart';
import 'package:authentication_and_authorization_frontend/src/modules/home/presenter/controllers/home_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignOutUsecase extends Mock implements ISignOutUsecase {}

void main() {
  late HomeCubit homeCubit;
  late MockSignOutUsecase mockSignOutUsecase;

  setUp(() {
    mockSignOutUsecase = MockSignOutUsecase();
    homeCubit = HomeCubit(mockSignOutUsecase);
  });

  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'should emits [HomeStatus.loading, HomeStatus.succeed]',
      build: () {
        when(() => mockSignOutUsecase.execute())
            .thenAnswer((_) async => Right(null));

        return homeCubit;
      },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        const HomeState(status: HomeStatus.loading),
        const HomeState(status: HomeStatus.succeed)
      ],
      verify: (cubit) {
        verify(() => mockSignOutUsecase.execute()).called(1);
      },
    );
  });
}
