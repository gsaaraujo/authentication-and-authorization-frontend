// ignore_for_file: public_member_api_docs, sort_constructors_first
enum SignInStatus {
  initial,
  loading,
  succeed,
  failed,
}

class SignInState {
  final SignInStatus status;
  final String errorMessage;

  SignInState({
    required this.status,
    this.errorMessage = '',
  });

  SignInState copyWith({SignInStatus? status, String? errorMessage}) {
    return SignInState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
