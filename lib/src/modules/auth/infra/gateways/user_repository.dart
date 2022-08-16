import 'package:authentication_and_authorization_frontend/src/modules/auth/data/models/user.dart';
import 'package:authentication_and_authorization_frontend/src/modules/auth/data/ports/user_repository.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/rest_client/interfaces/rest_client.dart';

class UserRepository implements IUserRepository {
  final IRestClient _restClient;

  UserRepository(this._restClient);

  @override
  Future<UserModel> signIn(String email, String password) async {
    final response = await _restClient.post(
      '/auth/sign-in',
      {"email": email, "password": password},
    );

    return UserModel(
      id: response['id'],
      name: response['name'],
      email: response['email'],
      accessToken: response['accessToken'],
      refreshToken: response['refreshToken'],
    );
  }
}
