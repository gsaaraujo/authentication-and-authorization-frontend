import 'package:equatable/equatable.dart';

enum SignInStatus {
  initial,
  loading,
  succeed,
  failed,
}

class SignInState extends Equatable {
  final SignInStatus status;
  final String errorMessage;

  const SignInState({
    required this.status,
    this.errorMessage = '',
  });

  SignInState copyWith({SignInStatus? status, String? errorMessage}) {
    return SignInState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
