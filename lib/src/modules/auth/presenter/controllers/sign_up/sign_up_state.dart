import 'package:equatable/equatable.dart';

enum SignUpStatus {
  initial,
  loading,
  succeed,
  failed,
}

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String errorMessage;

  const SignUpState({
    required this.status,
    this.errorMessage = '',
  });

  SignUpState copyWith({SignUpStatus? status, String? errorMessage}) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
