import 'package:authentication_and_authorization_frontend/src/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/src/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_register.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/dtos/user_signed.dart';

abstract class ISignUpUsecase {
  Future<Either<Failure, UserSignedDTO>> execute(UserRegisterDTO input);
}
