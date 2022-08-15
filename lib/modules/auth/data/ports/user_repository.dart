import 'package:authentication_and_authorization_frontend/modules/auth/data/models/user.dart';

abstract class IUserRepository {
  Future<UserModel> signIn(String email, String password);
}
