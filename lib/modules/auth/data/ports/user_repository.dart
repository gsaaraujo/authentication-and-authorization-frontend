import 'package:authentication_and_authorization_frontend/app/helpers/either.dart';
import 'package:authentication_and_authorization_frontend/app/helpers/failure.dart';
import 'package:authentication_and_authorization_frontend/modules/auth/data/models/user.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserModel>> signIn(String email, String password);
}
