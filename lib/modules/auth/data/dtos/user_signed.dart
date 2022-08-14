import 'package:equatable/equatable.dart';

class UserSignedDTO extends Equatable {
  final String id;
  final String name;
  final String email;

  const UserSignedDTO({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id];
}
