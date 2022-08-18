import 'package:equatable/equatable.dart';

class UserRegisterDTO extends Equatable {
  final String name;
  final String email;
  final String password;

  const UserRegisterDTO({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
