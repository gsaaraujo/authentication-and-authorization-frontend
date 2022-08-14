import 'package:authentication_and_authorization_frontend/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/dtos/user_credentials.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/dtos/user_signed.dart';

abstract class ISignInUsecase {
  Future<Either<Failure, UserSignedDTO>> execute(UserCredentialsDTO input);
}
