import 'package:authentication_and_authorization_frontend/src/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';

abstract class ISignOutUsecase {
  Future<Either<Failure, void>> execute();
}
