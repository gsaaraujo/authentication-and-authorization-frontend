import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String accessToken;
  final String refreshToken;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [id];
}
