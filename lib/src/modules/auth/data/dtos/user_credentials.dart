import 'package:equatable/equatable.dart';

class UserCredentialsDTO extends Equatable {
  final String email;
  final String password;

  const UserCredentialsDTO({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
