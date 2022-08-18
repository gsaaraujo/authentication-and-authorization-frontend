enum SignUpStatus {
  initial,
  loading,
  succeed,
  failed,
}

class SignUpState {
  final SignUpStatus status;
  final String errorMessage;

  SignUpState({
    required this.status,
    this.errorMessage = '',
  });

  SignUpState copyWith({SignUpStatus? status, String? errorMessage}) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
